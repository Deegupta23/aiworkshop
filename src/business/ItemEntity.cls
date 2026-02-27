/*------------------------------------------------------------------------
  File        : ItemEntity
  Purpose     : Business Entity for Item data access
  Syntax      : 
  Description : 
  Author(s)   : 
  Created     : Thu Feb 27 09:23:00 UTC 2026
  Notes       : 
------------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS business.ItemEntity INHERITS BusinessEntity USE-WIDGET-POOL:
    
    {business/ItemDataset.i}
    
    DEFINE DATA-SOURCE srcItem FOR Item.
    
    CONSTRUCTOR PUBLIC ItemEntity():
        SUPER(DATASET dsItem:HANDLE).

        VAR HANDLE[1] hDataSourceArray = DATA-SOURCE srcItem:HANDLE.
        VAR CHARACTER[1] cSkipListArray = [""].
        
        THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
    END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL GetItemByNumber(INPUT ipiItemNum AS INTEGER,
                                          OUTPUT DATASET dsItem):
        VAR CHARACTER cFilter.
        VAR LOGICAL lFound = FALSE.
        
        cFilter = "WHERE Item.ItemNum = " + STRING(ipiItemNum).
        
        THIS-OBJECT:ReadData(cFilter).
    
        lFound = CAN-FIND(FIRST ttItem).
        
        RETURN lFound.
    END METHOD.
    
    METHOD PUBLIC VOID UpdateItem(INPUT-OUTPUT DATASET dsItem):
        THIS-OBJECT:UpdateData(DATASET dsItem BY-REFERENCE).
    END METHOD.
    
    METHOD PUBLIC LOGICAL ValidateItem(INPUT-OUTPUT DATASET dsItem,
                                       OUTPUT errorMessage AS CHARACTER):
        VAR LOGICAL isValid = TRUE.
        VAR DECIMAL dTotal.
        
        FIND FIRST ttItem NO-ERROR.
        IF AVAILABLE ttItem THEN DO:
            IF ttItem.Price = 0 THEN DO:
                isValid = FALSE.
                errorMessage = "Price cannot be empty".
            END.
            ELSE DO:
                dTotal = ttItem.OnHand * ttItem.Price.
                IF dTotal > 6000 THEN DO:
                    isValid = FALSE.
                    errorMessage = "Total value onhand will be " + STRING(dTotal) + 
                                   ", should not be larger than 6000".
                END.
            END.
        END.
        
        RETURN isValid.
    END METHOD.

END CLASS.

/*------------------------------------------------------------------------
  File        : ItemEntity
  Purpose     : Business Entity for Item data access
  Syntax      : 
  Description : 
  Author(s)   : 
  Created     : Sun Feb 09 10:15:00 UTC 2026
  Notes       : 
----------------------------------------------------------------------*/

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
    
    METHOD PUBLIC LOGICAL ValidateItemPrice(INPUT ipdPrice AS DECIMAL,
                                           INPUT ipiOnHand AS INTEGER,
                                           OUTPUT opcErrorMessage AS CHARACTER):
        VAR LOGICAL lValid = TRUE.
        VAR DECIMAL dTotal.
        
        IF ipdPrice = 0 THEN DO:
            lValid = FALSE.
            opcErrorMessage = "Price cannot be empty".
            RETURN lValid.
        END.
        
        dTotal = ipiOnHand * ipdPrice.
        IF dTotal > 6000 THEN DO:
            lValid = FALSE.
            opcErrorMessage = "Total value onhand will be " + STRING(dTotal) + 
                            ", should not be larger than 6000".
            RETURN lValid.
        END.
        
        RETURN lValid.
    END METHOD.

END CLASS.

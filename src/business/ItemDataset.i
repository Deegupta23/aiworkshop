/*------------------------------------------------------------------------
  File        : ItemDataset.i
  Purpose     : Dataset definition for Item entity
  Syntax      : 
  Description : 
  Author(s)   : 
  Created     : Sun Feb 09 10:15:00 UTC 2026
  Notes       : 
----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttItem BEFORE-TABLE bttItem
    FIELD ItemNum AS INTEGER INITIAL "0" LABEL "Item Num"
    FIELD Price AS DECIMAL INITIAL "0" LABEL "Price"
    FIELD OnHand AS INTEGER INITIAL "0" LABEL "On Hand"
    INDEX ItemNum IS PRIMARY UNIQUE ItemNum ASCENDING.

DEFINE DATASET dsItem FOR ttItem.

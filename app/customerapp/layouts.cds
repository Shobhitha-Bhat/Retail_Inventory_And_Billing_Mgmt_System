// annotate AdminService.Customers with @UI: {
//     SelectionVariant #canceled: {
//         $Type           : 'UI.SelectionVariantType',
//         ID              : 'canceled',
//         Text            : 'canceled',
//         Parameters      : [

//         ],
//         FilterExpression: '',
//         SelectOptions   : [{
//             $Type       : 'UI.SelectOptionType',
//             PropertyName: TravelStatus_code,
//             Ranges      : [{
//                 $Type : 'UI.SelectionRangeType',
//                 Sign  : #I,
//                 Option: #EQ,
//                 Low   : 'X',
//             }, ],
//         }, ],
//     },SelectionVariant#open  : {
//          $Type : 'UI.SelectionVariantType',
//          ID : 'open',
//          Text : 'open',
//          Parameters : [

//          ],             
//          FilterExpression : '',
//          SelectOptions : [
//              {
//                  $Type : 'UI.SelectOptionType',
//                  PropertyName : TravelStatus_code,
//                  Ranges : [
//                      {
//                          $Type : 'UI.SelectionRangeType',
//                          Sign : #I,
//                          Option : #EQ,
//                          Low : 'O',
//                      },
//                  ],
//              },
//          ],
//      },    SelectionVariant #accepted: {
//         $Type           : 'UI.SelectionVariantType',
//         ID              : 'accepted',
//         Text            : 'accepted',
//         Parameters      : [

//         ],
//         FilterExpression: '',
//         SelectOptions   : [{
//             $Type       : 'UI.SelectOptionType',
//             PropertyName: TravelStatus_code,
//             Ranges      : [{
//                 $Type : 'UI.SelectionRangeType',
//                 Sign  : #I,
//                 Option: #EQ,
//                 Low   : 'A',
//             }, ],
//         }, ],
//     }
// };
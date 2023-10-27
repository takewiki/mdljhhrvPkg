#' src清除中间表
#'
#' @param token
#' @param FYear
#' @param FMonth
#' @param FExpenseOrgID
#'
#' @return 无返回值
#' @export
#'
#' @examples
#' srcmiddleTable()
srcmiddleTable<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete FROM  [jh_hrv_test].[dbo].[rds_hrv_src_ds_middleTable]
           where FYear ='",FYear,"'and FMonth='",FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'  ")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}
#' ods清除中间表
#'
#' @param token
#' @param FYear
#' @param FMonth
#' @param FExpenseOrgID
#'
#' @return 无返回值
#' @export
#'
#' @examples
#' odsmiddleTable()
odsmiddleTable<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete FROM  [jh_hrv_test].[dbo].[rds_hrv_ods_ds_middleTable]
           where FYear ='",FYear,"'and FMonth='",FMonth,"'
             and FExpenseOrgID ='",FExpenseOrgID,"'  ")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}

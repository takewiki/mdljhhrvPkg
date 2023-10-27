
#' src工资
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
#' srcrddetail()
srcrddetail<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete from rds_hrv_src_ds_rddetail  where
             FYear ='",FYear,"'and FMonth='",
             FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}



#' ods工资
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
#' odsrddetail()
odsrddetail<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete from rds_hrv_ods_ds_rddetail  where
             FYear ='",FYear,"'and FMonth='",
             FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}

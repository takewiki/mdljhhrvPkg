#' std工资
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
#' stdsalary()
stdsalary<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete from rds_hrv_std_ds_salary  where
             FYear ='",FYear,"'and FMonth='",FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}
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
#' srcsalary()
srcsalary<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete from rds_hrv_src_ds_salary  where
             FYear ='",FYear,"'and FMonth='",
             FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}



#' ods工资
#'
#' @param token
#'
#' @return 无返回值
#' @export
#'
#' @examples
#' odssalary()
odssalary<- function(token,FYear='2023',FMonth='8',FExpenseOrgID='江苏') {



  sql=paste0("delete from rds_hrv_ods_ds_salary  where
             FYear ='",FYear,"'and FMonth='",
             FMonth,"'and FExpenseOrgID ='",FExpenseOrgID,"'")

  res=tsda::sql_delete2(token = token,sql_str = sql)
  return(res)
}

#' 更新管理费
#'
#' @param token
#' @param FYear
#' @param FMonth
#'
#' @return 无返回值
#' @export
#'
#' @examples
#' updateMF()
updateMF<- function(token,FYear='2023',FMonth='8') {

  sql=paste0("update a set  a.FDefaultAmt = b.FDefaultAmt from rds_hrv_ods_tpl_defaultValue a
                        inner join rds_hrv_ods_vw_managementFeeYearPeriod2 b
                            on a.FNumber = b.FNumber and a.FSeq = b.FSeq
                             where b.FYear = '",FYear,"' and  b.FMonth = '",FMonth,"'")

  res=tsda::sql_update2(token = token,sql_str = sql)
  return(res)
}

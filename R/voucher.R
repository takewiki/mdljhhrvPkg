#' Title 获取当前会计期间数据，生成凭证过程表
#'
#' @param FToken 口令
#' @param FYear 会计年度
#' @param FMonth 会计期间
#' @param FOpthon 权限
#'
#' @return 是否运行成功
#' @export
#'
#' @examples outputvourchermain("057A7F0E-F187-4975-8873-AF71666429AB", "2023", "4", '账套查询DMS测试')
middlevourchermain <- function(FToken,FYear,FMonth,FOpthon) {
  #注册python模板
  mdl <- tsda::import('pyhrv.Main')
  #调用python函数，将.替代为$
  res <- mdl$action(FToken,FYear,FMonth,FOpthon)
  #返回结果
  return(TRUE)
}


#' Title 获取当前会计期间数据，生成凭证
#'
#' @param FToken 口令
#' @param FYear 会计年度
#' @param FMonth 会计期间
#' @param FOpthon 权限
#'
#' @return 是否运行成功
#' @export
#'
#' @examples reoutputvourchermain("057A7F0E-F187-4975-8873-AF71666429AB", "2023", "4", '账套查询DMS测试')
outputvourchermain <- function(FToken,FYear,FMonth,FOpthon) {
  #注册python模板
  mdl <- tsda::import('pyhrv.Main')
  #调用python函数，将.替代为$
  res <- mdl$vch_save(FToken,FYear,FMonth,FOpthon)
  #返回结果
  return(TRUE)
}

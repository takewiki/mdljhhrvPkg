#' 凭证数据源上传
#'
#' @param dms_token 口令
#' @param file_name 文件名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' ds_voucher_upload()
ds_voucher_upload <- function(dms_token,file_name="data-raw/模板表上海嘉好20230715.xlsx") {
  dsql = 'truncate table rds_hrv_src_ds_salary_input'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'truncate table rds_hrv_src_ds_socialsecurity_input'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'truncate table rds_hrv_src_ds_rddetail_input'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'truncate table rds_hrv_src_ds_nonrddetail_input'
  tsda::sql_update2(token = dms_token, sql_str = dsql)


  # 获取文件路径
  # file_name = var_file_export_baseInfo()
  print(file_name)

  salary_data_excel <-
    readxl::read_excel(
      file_name,
      sheet = '工资',
      col_types = c(
        "text",
        "text",
        "text",
        "text",
        # "text",
        "text",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "text",
        "text",
        "text",
        "numeric",
        "date",
        "text",
        "text"
      )
    )



  names(salary_data_excel) = c(
    'FExpenseOrgID',
    'FTaxDeclarationOrg',
    'FBankType',
    'FAccount',
    # 'FHightechDept',
    'FRdProject',
    'FCpayAmount',
    'FFixdCost',
    'FScraprateCost',
    'FSocialSecurityAmt',
    'FAccumulationFundAmt',
    'FOtherAmt',
    'FIncomeTaxAmt',
    'FActualAmount',
    'FYear',
    'FMonth',
    'FVoucher',
    'FCategoryType',
    'FNumber',
    'FSeq',
    'FDate',
    'FOldDept',
    'FNotePeriod'
  )

  FHightechDept = ''
  salary_data_excel = cbind(salary_data_excel[, 1:4], FHightechDept, salary_data_excel[, 5:ncol(salary_data_excel)])

  salary_data_excel = as.data.frame(salary_data_excel)
  salary_data_excel = tsdo::na_standard(salary_data_excel)

  # 写入中间表
  tsda::db_writeTable2(
    token = dms_token,
    table_name = 'rds_hrv_src_ds_salary_input',
    r_object = salary_data_excel,
    append = TRUE
  )

  sql = 'insert into rds_hrv_src_ds_salary_history select * from rds_hrv_src_ds_salary  where FNumber in (select FNumber from rds_hrv_src_ds_salary_input)'
  tsda::sql_insert2(token = dms_token, sql_str = sql)

  dsql = 'delete a from rds_hrv_src_ds_salary  a inner join rds_hrv_src_ds_salary_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'delete a from rds_hrv_ods_ds_salary  a inner join rds_hrv_src_ds_salary_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'delete a from rds_hrv_std_ds_salary  a inner join rds_hrv_src_ds_salary_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  isql = 'insert into rds_hrv_src_ds_salary  select * from rds_hrv_src_ds_salary_input'
  tsda::sql_insert2(token = dms_token, sql_str = isql)

  # dsql = 'truncate table rds_hrv_src_ds_salary_input'
  # tsda::sql_update2(token = dms_token, sql_str = dsql)


  socialsecurity_data_excel <-
    readxl::read_excel(
      file_name,
      sheet = '社保',
      col_types = c(
        "text",
        "text",
        "text",
        # "text",
        "text",
        "text",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "numeric",
        "text",
        "text",
        "text",
        "numeric",
        "date",
        "text",
        "text"

      )
    )
  names(socialsecurity_data_excel) = c(
    'FExpenseOrgID',
    'FTaxDeclarationOrg',
    'FBankType',
    # 'FHightechDept',
    'FAccount',
    'FRdProject',
    'FComPensionBenefitsAmt',
    'FComMedicareAmt',
    'FComMedicareOfSeriousAmt',
    'FComDisabilityBenefitsAmt',
    'FComOffsiteElseAmt',
    'FComWorklessInsuranceAmt',
    'FComInjuryInsuranceAmt',
    'FComMaternityInsuranceAmt',
    'FComAllSocialSecurityAmt',
    'FComAccumulationFundAmt',
    'FComAllSoSeAcFuAmt',
    'FEmpPensionBenefitsAmt',
    'FEmpMedicareAmt',
    'FEmpMedicareOfSeriousAmt',
    'FEmpWorklessInsuranceAmt',
    'FEmpAllSocialSecurityAmt',
    'FEmpAccumulationFundAmt',
    'FEmpAllSoSeAcFuAmt',
    'FAllSocialSecurityAmt',
    'FAllAccumulationFundAmt',
    'FAllAmount',
    'FManagementAmount',
    'FYear',
    'FMonth',
    'FVoucher',
    'FCategoryType',
    'FNumber',
    'FSeq',
    'FDate',
    'FOldDept',
    'FNotePeriod'
  )

  # socialsecurity_data_excel$FHightechDept = ''

  FHightechDept = ''
  socialsecurity_data_excel = cbind(socialsecurity_data_excel[, 1:3],
                                    FHightechDept,
                                    socialsecurity_data_excel[, 4:ncol(socialsecurity_data_excel)])

  socialsecurity_data_excel = as.data.frame(socialsecurity_data_excel)
  socialsecurity_data_excel = tsdo::na_standard(socialsecurity_data_excel)


  # 写入社保公积金中间表
  tsda::db_writeTable2(
    token = dms_token,
    table_name = 'rds_hrv_src_ds_socialsecurity_input',
    r_object = socialsecurity_data_excel,
    append = TRUE
  )

  sql = 'insert into rds_hrv_src_ds_socialsecurity_history select * from rds_hrv_src_ds_socialsecurity  where FNumber in (select FNumber from rds_hrv_src_ds_socialsecurity_input)'
  tsda::sql_insert2(token = dms_token, sql_str = sql)

  dsql = 'delete a from rds_hrv_src_ds_socialsecurity  a inner join rds_hrv_src_ds_socialsecurity_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'delete a from rds_hrv_ods_ds_socialsecurity  a inner join rds_hrv_src_ds_socialsecurity_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'delete a from rds_hrv_std_ds_socialsecurity  a inner join rds_hrv_src_ds_socialsecurity_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  isql = 'insert into rds_hrv_src_ds_socialsecurity  select * from rds_hrv_src_ds_socialsecurity_input'
  tsda::sql_insert2(token = dms_token, sql_str = isql)

  # dsql = 'truncate table rds_hrv_src_ds_socialsecurity_input'
  # tsda::sql_update2(token = dms_token, sql_str = dsql)



  #读取文件
  redetail <-
    readxl::read_excel(file_name, sheet = '工时')

  ncols = ncol(redetail)
  c1 = c("numeric",
         "text", "numeric", "numeric", "text",
         "text", "text", "text", "text", "numeric",
         "numeric", "numeric", "text")

  c2<-rep("numeric",times= (ncols - 13))
  col_types = c(c1, c2)

  redetail <- readxl::read_excel(file_name,
                                 sheet = "工时", col_types = col_types)

  redetail = as.data.frame(redetail)
  redetail = tsdo::na_standard(redetail)

  # 将非研发金额空值替换为0
  # redetail$非研发工资成本          = tsdo::na_replace(redetail$非研发工资成本, 0)

  # 非研发工时表字段
  col_nonrd = c(
    '序号',
    '工资类别',
    '会计年度',
    '会计期间',
    '原部门',
    '高新部门',
    '姓名',
    '费用承担组织',
    '个税申报组织',
    '单据编号',
    '非研发工资成本'
  )

  # 筛选非研发金额不为0的数据
  nonrddetail = redetail[redetail$非研发工资成本           != 0, col_nonrd]

  # 更名为数据库字段名
  names(nonrddetail) = c(
    'FNO',
    'FSalaryType',
    'FYear',
    'FMonth',
    'FOldDept',
    'FHightechDept',
    'FStaffName',
    'FExpenseOrgID',
    'FTaxDeclarationOrg',
    'FNumber',
    'FNonRdCost'
  )


  if (nrow(nonrddetail) > 0) {
    nonrddetail$FRdProject = ''

    # 写入非研发工时中间表
    tsda::db_writeTable2(
      token = dms_token,
      table_name = 'rds_hrv_src_ds_nonrddetail_input',
      r_object = nonrddetail,
      append = TRUE
    )

    sql = 'insert into rds_hrv_src_ds_nonrddetail_history select * from rds_hrv_src_ds_nonrddetail  where FNumber in (select FNumber from rds_hrv_src_ds_nonrddetail_input)'
    tsda::sql_insert2(token = dms_token, sql_str = sql)

    dsql = 'delete a from rds_hrv_src_ds_nonrddetail  a inner join rds_hrv_src_ds_nonrddetail_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
    tsda::sql_update2(token = dms_token, sql_str = dsql)

    dsql = 'delete a from rds_hrv_ods_ds_nonrddetail  a inner join rds_hrv_src_ds_nonrddetail_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
    tsda::sql_update2(token = dms_token, sql_str = dsql)

    isql = 'insert into rds_hrv_src_ds_nonrddetail  select * from rds_hrv_src_ds_nonrddetail_input'
    tsda::sql_insert2(token = dms_token, sql_str = isql)

    # dsql = 'truncate table rds_hrv_src_ds_nonrddetail_input'
    # tsda::sql_update2(token = dms_token, sql_str = dsql)
  }


  # 工时表固定字段
  col_fixed = c(
    '序号',
    '工资类别',
    '会计年度',
    '会计期间',
    '原部门',
    '高新部门',
    '姓名',
    '费用承担组织',
    '个税申报组织',
    '单据编号',
    '单项总额',
    '研发工资成本',
    '非研发工资成本'
  )

  # 研发项目列转行
  redetail2 <-
    reshape2::melt(
      data = redetail,
      id.vars = col_fixed,
      variable.name = '研发项目',
      value.name = '研发金额'
    )

  # 研发工时表字段
  col_rd = c(
    '序号',
    '工资类别',
    '会计年度',
    '会计期间',
    '原部门',
    '高新部门',
    '姓名',
    '费用承担组织',
    '个税申报组织',
    '单据编号',
    '研发项目',
    '研发金额'
  )

  # 筛选研发工时需要字段
  rddetail = redetail2[, col_rd]

  # 研发金额为空时替换为0
  # rddetail$研发金额   = tsdo::na_replace(rddetail$研发金额, 0)

  # 筛选研发金额不为0数据
  rddetail = rddetail[rddetail$研发金额           != 0, col_rd]

  # 替换为数据库字段
  names(rddetail) = c(
    'FNO',
    'FSalaryType',
    'FYear',
    'FMonth',
    'FOldDept',
    'FHightechDept',
    'FStaffName',
    'FExpenseOrgID',
    'FTaxDeclarationOrg',
    'FNumber',
    'FRdProject',
    'FRdProjectCost'
  )



  # 写入研发工时中间表
  tsda::db_writeTable2(
    token = dms_token,
    table_name = 'rds_hrv_src_ds_rddetail_input',
    r_object = rddetail,
    append = TRUE
  )

  sql = 'insert into rds_hrv_src_ds_rddetail_history select * from rds_hrv_src_ds_rddetail  where FNumber in (select FNumber from rds_hrv_src_ds_rddetail_input)'
  tsda::sql_insert2(token = dms_token, sql_str = sql)

  dsql = 'delete a from rds_hrv_src_ds_rddetail  a inner join rds_hrv_src_ds_rddetail_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  dsql = 'delete a from rds_hrv_ods_ds_rddetail  a inner join rds_hrv_src_ds_rddetail_input b On a.FNumber=b.FNumber and a.FYear =b.FYear and a.FMonth =b.FMonth'
  tsda::sql_update2(token = dms_token, sql_str = dsql)

  isql = 'insert into rds_hrv_src_ds_rddetail  select * from rds_hrv_src_ds_rddetail_input'
  tsda::sql_insert2(token = dms_token, sql_str = isql)

  # dsql = 'truncate table rds_hrv_src_ds_rddetail_input'
  # tsda::sql_update2(token = dms_token, sql_str = dsql)
  res <- TRUE
  return(res)

}

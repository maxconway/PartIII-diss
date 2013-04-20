NameLookup <- function(string){
  switch(string,
         iaf1260-ac='iaf1260-ac',
         iJO1366_Ecoli_suc_aerobic='iJO1366-aerobic',
         iJO1366_Ecoli_suc_anaerobic='iJO1366-anaerobic',
         geo_m_react='metallireducens',
         geo_s_react='sulfurreducens',
         
         iaf1260-ac='iaf1260-ac',
         iJO1366-aerobic='iJO1366_Ecoli_suc_aerobic',
         iJO1366-anaerobic='iJO1366_Ecoli_suc_anaerobic',
         metallireducens='geo_m_react',
         sulfurreducens='geo_s_react')
}
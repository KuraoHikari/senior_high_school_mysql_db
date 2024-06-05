CALL AnalyzeTable('siswa');
CALL AnalyzeTable('guru');
CALL AnalyzeTable('mata_pelajaran');

CALL CheckTable('siswa');
CALL CheckTable('guru');
CALL CheckTable('mata_pelajaran');

CALL OptimizeTable('siswa');
CALL OptimizeTable('guru');
CALL OptimizeTable('mata_pelajaran');

CALL RepairTable('siswa');
CALL RepairTable('guru');
CALL RepairTable('mata_pelajaran');

CALL FlushTable('siswa');
CALL FlushTable('guru');
CALL FlushTable('mata_pelajaran');

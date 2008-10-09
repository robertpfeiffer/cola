void __libc_csu_init() {}
void __libc_csu_fini() {}

void __libc_start_main(int (*main)(), int argc, char **argv)
{
  void exit();
  static char **envp= { 0 };
  exit(main(argc, argv, envp));
}

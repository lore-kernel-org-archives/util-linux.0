Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57206 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab1FBTPg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Jun 2011 15:15:36 -0400
Received: by ewy4 with SMTP id 4so420634ewy.19
        for <util-linux@vger.kernel.org>; Thu, 02 Jun 2011 12:15:35 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] simpleinit: remove NLS support
Date: Thu,  2 Jun 2011 21:15:26 +0200
Message-Id: <1307042126-7242-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

About 50 messages to translate less.

shutdown(1) is deprecated since July 2007, simpleinit(1), initctl(1)
are deprecated since December 2010. They are marked as deprecated why
nobody uses these implementations.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 simpleinit/shutdown.c   |   64 ++++++++++++++++++++++------------------------
 simpleinit/simpleinit.c |   42 ++++++++++++++----------------
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/simpleinit/shutdown.c b/simpleinit/shutdown.c
index 9bb121c..6c6fe52 100644
--- a/simpleinit/shutdown.c
+++ b/simpleinit/shutdown.c
@@ -113,7 +113,7 @@ void
 usage(void)
 {
 	fprintf(stderr,
-		_("Usage: shutdown [-h|-r] [-fqs] [now|hh:ss|+mins]\n"));
+		"Usage: shutdown [-h|-r] [-fqs] [now|hh:ss|+mins]\n");
 	exit(EXIT_FAILURE);
 }
 
@@ -131,7 +131,7 @@ int_handler(int sig)
 {
 	unlink(_PATH_NOLOGIN);
 	signal(SIGINT, SIG_DFL);
-	my_puts(_("Shutdown process aborted"));
+	my_puts("Shutdown process aborted");
 	_exit(EXIT_FAILURE);
 }
 
@@ -157,12 +157,10 @@ main(int argc, char *argv[])
 	for (i = 1; i < NSIG; i++) signal (i, SIG_DFL);
 
         setlocale(LC_ALL, "");
-        bindtextdomain(PACKAGE, LOCALEDIR);
-        textdomain(PACKAGE);
 
 #ifndef DEBUGGING
 	if(setreuid (0, 0))
-		errx(EXIT_FAILURE, _("only root can shut a system down."));
+		errx(EXIT_FAILURE, "only root can shut a system down.");
 #endif
 
 	if(*argv[0] == '-') argv[0]++;	/* allow shutdown as login shell */
@@ -252,8 +250,8 @@ main(int argc, char *argv[])
 			then = 3600 * hour + 60 * minute;
 			timeout = then - now;
 			if(timeout < 0)
-				errx(EXIT_FAILURE, _("that must be tomorrow, "
-					          "can't you wait till then?"));
+				errx(EXIT_FAILURE, "that must be tomorrow, "
+					          "can't you wait till then?");
 		} else {
 			xstrncpy(message, argv[c], sizeof(message));
 			opt_msgset = 1;
@@ -301,7 +299,7 @@ main(int argc, char *argv[])
 		}
 		*ptr = '\0';
 	} else if (!opt_msgset) {
-		strcpy(message, _("for maintenance; bounce, bounce"));
+		strcpy(message, "for maintenance; bounce, bounce");
 	}
 
 #ifdef DEBUGGING
@@ -329,11 +327,11 @@ main(int argc, char *argv[])
 	if((fd = open(_PATH_NOLOGIN, O_WRONLY|O_CREAT, 0644)) >= 0) {
 		/* keep xgettext happy and leave \r\n outside strings */
 		WRCRLF;
-		WR(_("The system is being shut down within 5 minutes"));
+		WR("The system is being shut down within 5 minutes");
 		WRCRLF;
 		write(fd, message, strlen(message));
 		WRCRLF;
-		WR(_("Login is therefore prohibited."));
+		WR("Login is therefore prohibited.");
 		WRCRLF;
 		close(fd);
 	}
@@ -355,10 +353,10 @@ main(int argc, char *argv[])
 	/* do syslog message... */
 	openlog(prog, LOG_CONS, LOG_AUTH);
 	if (opt_reboot)
-		syslog(LOG_NOTICE, _("rebooted by %s: %s"), 
+		syslog(LOG_NOTICE, "rebooted by %s: %s",
 		       whom, message);
 	else
-		syslog(LOG_NOTICE, _("halted by %s: %s"), 
+		syslog(LOG_NOTICE, "halted by %s: %s",
 		       whom, message);
 	closelog();
 
@@ -422,9 +420,9 @@ main(int argc, char *argv[])
 
 	if(opt_reboot) {
 		my_reboot(LINUX_REBOOT_CMD_RESTART); /* RB_AUTOBOOT */
-		my_puts(_("\nWhy am I still alive after reboot?"));
+		my_puts("\nWhy am I still alive after reboot?");
 	} else {
-		my_puts(_("\nNow you can turn off the power..."));
+		my_puts("\nNow you can turn off the power...");
 
 		/* allow C-A-D now, faith@cs.unc.edu, re-fixed 8-Jul-96 */
 		my_reboot(LINUX_REBOOT_CMD_CAD_ON); /* RB_ENABLE_CAD */
@@ -440,10 +438,10 @@ main(int argc, char *argv[])
 void
 do_halt(char *action) {
 	if (strcasecmp (action, "power_off") == 0) {
-		printf(_("Calling kernel power-off facility...\n"));
+		printf("Calling kernel power-off facility...\n");
 		fflush(stdout);
 		my_reboot(LINUX_REBOOT_CMD_POWER_OFF);
-		printf(_("Error powering off\t%s\n"), ERRSTRING);
+		printf("Error powering off\t%s\n", ERRSTRING);
 		fflush(stdout);
 		sleep (2);
 	} else
@@ -451,10 +449,10 @@ do_halt(char *action) {
 	/* This should be improved; e.g. Mike Jagdis wants "/sbin/mdstop -a" */
 	/* Maybe we should also fork and wait */
 	if (action[0] == '/') {
-		printf(_("Executing the program \"%s\" ...\n"), action);
+		printf("Executing the program \"%s\" ...\n", action);
 		fflush(stdout);
 		execl(action, action, NULL);
-		printf(_("Error executing\t%s\n"), ERRSTRING);
+		printf("Error executing\t%s\n", ERRSTRING);
 		fflush(stdout);
 		sleep (2);
 	}
@@ -481,29 +479,29 @@ write_user(struct utmp *ut)
 	        return;
 
 	msg[0] = '\007';	/* gettext crashes on \a */
-	sprintf(msg+1, _("URGENT: broadcast message from %s:"), whom);
+	sprintf(msg+1, "URGENT: broadcast message from %s:", whom);
 	WRCRLF;
 	WR(msg);
 	WRCRLF;
 
 	if (hours > 1)
-		sprintf(msg, _("System going down in %d hours %d minutes"),
+		sprintf(msg, "System going down in %d hours %d minutes",
 			hours, minutes);
 	else if (hours == 1)
-		sprintf(msg, _("System going down in 1 hour %d minutes"),
+		sprintf(msg, "System going down in 1 hour %d minutes",
 			minutes);
 	else if (minutes > 1)
-		sprintf(msg, _("System going down in %d minutes\n"),
+		sprintf(msg, "System going down in %d minutes\n",
 			minutes);
 	else if (minutes == 1)
-		sprintf(msg, _("System going down in 1 minute\n"));
+		sprintf(msg, "System going down in 1 minute\n");
 	else
-		sprintf(msg, _("System going down IMMEDIATELY!\n"));
+		sprintf(msg, "System going down IMMEDIATELY!\n");
 
 	WR(msg);
 	WRCRLF;
 
-	sprintf(msg, _("\t... %s ...\n"), message);
+	sprintf(msg, "\t... %s ...\n", message);
 	WR(msg);
 	WRCRLF;
 
@@ -560,7 +558,7 @@ swap_off(void)
 
 	sync();
 	if ((pid = fork()) < 0) {
-		my_puts(_("Cannot fork for swapoff. Shrug!"));
+		my_puts("Cannot fork for swapoff. Shrug!");
 		return;
 	}
 	if (!pid) {
@@ -568,8 +566,8 @@ swap_off(void)
 		execl("/etc/swapoff", SWAPOFF_ARGS, NULL);
 		execl("/bin/swapoff", SWAPOFF_ARGS, NULL);
 		execlp("swapoff", SWAPOFF_ARGS, NULL);
-		my_puts(_("Cannot exec swapoff, "
-			  "hoping umount will do the trick."));
+		my_puts("Cannot exec swapoff, "
+			  "hoping umount will do the trick.");
 		exit(EXIT_SUCCESS);
 	}
 	while ((result = wait(&status)) != -1 && result != pid)
@@ -587,7 +585,7 @@ unmount_disks(void)
 
 	sync();
 	if ((pid = fork()) < 0) {
-		my_puts(_("Cannot fork for umount, trying manually."));
+		my_puts("Cannot fork for umount, trying manually.");
 		unmount_disks_ourselves();
 		return;
 	}
@@ -596,16 +594,16 @@ unmount_disks(void)
 
 		/* need my_printf instead of my_puts here */
 		freopen(_PATH_CONSOLE, "w", stdout);
-		printf(_("Cannot exec %s, trying umount.\n"), _PATH_UMOUNT);
+		printf("Cannot exec %s, trying umount.\n", _PATH_UMOUNT);
 		fflush(stdout);
 
 		execlp("umount", UMOUNT_ARGS, NULL);
-		my_puts(_("Cannot exec umount, giving up on umount."));
+		my_puts("Cannot exec umount, giving up on umount.");
 		exit(EXIT_SUCCESS);
 	}
 	while ((result = wait(&status)) != -1 && result != pid)
 		;
-	my_puts(_("Unmounting any remaining filesystems..."));
+	my_puts("Unmounting any remaining filesystems...");
 	unmount_disks_ourselves();
 }
 
@@ -652,7 +650,7 @@ unmount_disks_ourselves(void)
 		printf("umount %s\n", filesys);
 #else
 		if (umount(mntlist[i]) < 0)
-			printf(_("shutdown: Couldn't umount %s: %s\n"),
+			printf("shutdown: Couldn't umount %s: %s\n",
 			       filesys, ERRSTRING);
 #endif
 	}
diff --git a/simpleinit/simpleinit.c b/simpleinit/simpleinit.c
index d7f9655..8493d70 100644
--- a/simpleinit/simpleinit.c
+++ b/simpleinit/simpleinit.c
@@ -134,15 +134,15 @@ static void enter_single (void)
     pid_t pid;
     int i;
 
-    err(_("Booting to single user mode.\n"));
+    err("Booting to single user mode.\n");
     if((pid = fork()) == 0) {
 	/* the child */
 	execl(_PATH_BSHELL, _PATH_BSHELL, NULL);
-	err(_("exec of single user shell failed\n"));
+	err("exec of single user shell failed\n");
     } else if(pid > 0) {
 	while (waitpid (pid, &i, 0) != pid)  /*  Nothing  */;
     } else if(pid < 0) {
-	err(_("fork of single user shell failed\n"));
+	err("fork of single user shell failed\n");
     }
     unlink(_PATH_SINGLE);
 }
@@ -173,8 +173,6 @@ int main(int argc, char *argv[])
 	sigaction (SIGQUIT, &sa, NULL);
 
 	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
 
 	my_reboot (LINUX_REBOOT_CMD_CAD_OFF);
 	/*  Find script to run. Command-line overrides config file overrides
@@ -210,11 +208,11 @@ int main(int argc, char *argv[])
 	if ( ( initctl_fd = open (initctl_name, O_RDWR, 0) ) < 0 ) {
 		mkfifo (initctl_name, S_IRUSR | S_IWUSR);
 		if ( ( initctl_fd = open (initctl_name, O_RDWR, 0) ) < 0 )
-			err ( _("error opening fifo\n") );
+			err ("error opening fifo\n");
 	}
 
 	if (initctl_fd >= 0 && fcntl(initctl_fd, F_SETFD, FD_CLOEXEC) != 0) {
-		err ( _("error setting close-on-exec on /dev/initctl") );
+		err ("error setting close-on-exec on /dev/initctl");
 
 		/* Can the fcntl ever fail?  If it does, and we leave
 		   the descriptor open in child processes, then any
@@ -261,11 +259,11 @@ int main(int argc, char *argv[])
 		{
 		  case 0:   /*  Child   */
 		    execl (final_prog, final_prog, "start", NULL);
-		    err ( _("error running finalprog\n") );
+		    err ("error running finalprog\n");
 		    _exit (EXIT_FAILURE);
 		    break;
 		  case -1:  /*  Error   */
-		    err ( _("error forking finalprog\n") );
+		    err ("error forking finalprog\n");
 		    break;
 		  default:  /*  Parent  */
 		    break;
@@ -342,12 +340,12 @@ static int check_single_ok (void)
 
     for (i = 0; i < MAXTRIES; i++)
     {
-	pass = getpass (_("Password: "));
+	pass = getpass ("Password: ");
 	if (pass == NULL) continue;
 
 	if ( !strcmp (crypt (pass, rootpass), rootpass) ) return 1;
 
-	puts (_("\nWrong password.\n"));
+	puts ("\nWrong password.\n");
     }
     return 0;
 }
@@ -420,7 +418,7 @@ static int process_path (const char *path, int (*func) (const char *path),
 
     if (lstat (path, &statbuf) != 0)
     {
-	err (_("lstat of path failed\n") );
+	err ("lstat of path failed\n");
 	return 1;
     }
     if ( S_ISLNK (statbuf.st_mode) )
@@ -428,7 +426,7 @@ static int process_path (const char *path, int (*func) (const char *path),
 	if (stat (path, &statbuf) != 0)
 	{
 	    if ( (errno == ENOENT) && ignore_dangling_symlink ) return 0;
-	    err (_("stat of path failed\n") );
+	    err ("stat of path failed\n");
 	    return 1;
 	}
     }
@@ -436,7 +434,7 @@ static int process_path (const char *path, int (*func) (const char *path),
     if ( !S_ISDIR (statbuf.st_mode) ) return (*func) (path);
     if ( ( dp = opendir (path) ) == NULL )
     {
-	err (_("open of directory failed\n") );
+	err ("open of directory failed\n");
 	return 1;
     }
     while ( ( de = readdir (dp) ) != NULL )
@@ -503,7 +501,7 @@ static void spawn (int i)
 		inittab[i].pid = -1;
 		inittab[i].rate = 0;
 		snprintf (txt, sizeof(txt),
-			_("respawning: \"%s\" too fast: quenching entry\n"),
+			"respawning: \"%s\" too fast: quenching entry\n",
 			 inittab[i].tty);
 		err (txt);
 		return;
@@ -511,7 +509,7 @@ static void spawn (int i)
 
 	if((pid = fork()) < 0) {
 		inittab[i].pid = -1;
-		err(_("fork failed\n"));
+		err("fork failed\n");
 		return;
 	}
 	if(pid) {
@@ -542,7 +540,7 @@ static void spawn (int i)
 		env[2] = (char *)0;
 
 		execve(inittab[i].toks[0], inittab[i].toks, env);
-		err(_("exec failed\n"));
+		err("exec failed\n");
 		sleep(5);
 		_exit(EXIT_FAILURE);
 	}
@@ -566,7 +564,7 @@ static void read_inittab (void)
 	/* termenv = "vt100"; */
 			
 	if(!(f = fopen(_PATH_INITTAB, "r"))) {
-		err(_("cannot open inittab\n"));
+		err("cannot open inittab\n");
 		return;
 	}
 
@@ -633,7 +631,7 @@ static void read_inittab (void)
 		/* special-case termcap for the console ttys */
 		snprintf(tty, sizeof(tty), "/dev/%s", inittab[i].tty);
 		if(!termenv || stat(tty, &stb) < 0) {
-			err(_("no TERM or cannot stat tty\n"));
+			err("no TERM or cannot stat tty\n");
 		} else {
 			/* is it a console tty? */
 			if(major(stb.st_rdev) == 4 && minor(stb.st_rdev) < 64)
@@ -940,7 +938,7 @@ static void process_command (const struct command_struct *command)
 		execlp (get_path (victim->first_service->name),
 			victim->first_service->name, "stop", NULL);
 		snprintf (txt, sizeof(txt),
-			_("error at stopping service \"%s\"\n"),
+			"error at stopping service \"%s\"\n",
 			 victim->first_service->name);
 		err (txt);
 		_exit (SIG_NOT_STOPPED);
@@ -952,7 +950,7 @@ static void process_command (const struct command_struct *command)
 		if ( WIFEXITED (ival) && (WEXITSTATUS (ival) == 0) )
 		{
 		    snprintf (txt, sizeof(txt),
-			     _("Stopped service: %s\n"),
+			     "Stopped service: %s\n",
 			     victim->first_service->name);
 		    remove_entry (&available_list, victim);
 		    free (victim);
@@ -1072,7 +1070,7 @@ static int run_command (const char *file, const char *name, pid_t pid)
 	    for (i = 1; i < NSIG; i++) signal (i, SIG_DFL);
 	    execlp (get_path (file), service->name, "start", NULL);
 	    snprintf (txt, sizeof(txt),
-		_("error at starting service \"%s\"\n"), service->name);
+		"error at starting service \"%s\"\n", service->name);
 	    err (txt);
 	    _exit (SIG_FAILED);
 	    break;
-- 
1.7.3.4


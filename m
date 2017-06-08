Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38020 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdFHTwW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:22 -0400
Received: by mail-wm0-f48.google.com with SMTP id n195so37730981wmg.1
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/11] misc: fallthrough fixes
Date: Thu,  8 Jun 2017 20:52:05 +0100
Message-Id: <20170608195215.1702-2-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=7652
Reference: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c            |  8 ++++----
 disk-utils/fdisk-menu.c        |  2 +-
 disk-utils/mkfs.cramfs.c       |  2 +-
 disk-utils/mkfs.minix.c        |  2 +-
 disk-utils/sfdisk.c            |  6 +++---
 include/c.h                    | 18 ++++++++++++++++++
 libblkid/src/topology/md.c     |  4 ++--
 libsmartcols/src/table_print.c |  2 +-
 login-utils/last.c             |  2 +-
 login-utils/lslogins.c         |  4 ++--
 login-utils/su-common.c        |  1 +
 login-utils/sulogin.c          |  7 +++----
 misc-utils/cal.c               |  8 ++++----
 misc-utils/findmnt.c           |  2 +-
 misc-utils/lsblk.c             |  2 +-
 misc-utils/rename.c            |  3 +--
 sys-utils/flock.c              |  2 +-
 sys-utils/hwclock.c            |  3 ++-
 sys-utils/ipcrm.c              |  3 +++
 sys-utils/lsipc.c              |  2 +-
 sys-utils/nsenter.c            |  2 +-
 sys-utils/setarch.c            |  2 +-
 sys-utils/unshare.c            |  2 +-
 term-utils/agetty.c            |  4 ++--
 term-utils/script.c            |  4 ++--
 text-utils/hexdump-parse.c     |  2 +-
 text-utils/more.c              |  5 +++--
 text-utils/pg.c                |  4 ++--
 text-utils/ul.c                |  4 ++--
 29 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 37f998bab..1b2bc11fb 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1496,7 +1496,7 @@ static int ui_menu_move(struct cfdisk *cf, int key)
 				ui_menu_goto(cf, (int) m->idx - m->page_sz);
 				return 0;
 			}
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case KEY_HOME:
 			ui_menu_goto(cf, 0);
 			return 0;
@@ -1505,7 +1505,7 @@ static int ui_menu_move(struct cfdisk *cf, int key)
 				ui_menu_goto(cf, m->idx + m->page_sz);
 				return 0;
 			}
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case KEY_END:
 			ui_menu_goto(cf, m->nitems);
 			return 0;
@@ -2503,7 +2503,7 @@ static int ui_run(struct cfdisk *cf)
 				ui_table_goto(cf, (int) cf->lines_idx - cf->page_sz);
 				break;
 			}
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case KEY_HOME:
 			ui_table_goto(cf, 0);
 			break;
@@ -2512,7 +2512,7 @@ static int ui_run(struct cfdisk *cf)
 				ui_table_goto(cf, cf->lines_idx + cf->page_sz);
 				break;
 			}
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case KEY_END:
 			ui_table_goto(cf, (int) cf->nlines - 1);
 			break;
diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index 9ab28c43f..e42ebcd56 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -579,7 +579,7 @@ static int generic_menu_cb(struct fdisk_context **cxt0,
 		rc = fdisk_reread_partition_table(cxt);
 		if (!rc)
 			rc = fdisk_deassign_device(cxt, 0);
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case 'q':
 		fdisk_unref_context(cxt);
 		fputc('\n', stdout);
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index f277aaf23..77b4467e7 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -123,7 +123,7 @@ struct entry {
 #define CRAMFS_OFFSET_WIDTH 26
 
 /* Input status of 0 to print help and exit without an error. */
-static void
+static void __attribute__((__noreturn__))
 usage(int status) {
 	FILE *stream = status ? stderr : stdout;
 
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 47a155c55..fa7dc3270 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -765,7 +765,7 @@ int main(int argc, char ** argv)
 			break;
 		case 'v': /* kept for backwards compatibility */
 			warnx(_("-v is ambiguous, use '-2' instead"));
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case '2':
 			fs_version = 2;
 			break;
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 2ac8cef02..f0b391de3 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1825,7 +1825,7 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 				break;
 			}
 		}
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case SFDISK_DONE_WRITE:
 		rc = write_changes(sf);
 		break;
@@ -2025,7 +2025,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'J':
 			sf->json = 1;
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case 'd':
 			sf->act = ACT_DUMP;
 			break;
@@ -2037,7 +2037,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'G':
 			warnx(_("--show-pt-geometry is no more implemented. Using --show-geometry."));
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case 'g':
 			sf->act = ACT_SHOW_GEOM;
 			break;
diff --git a/include/c.h b/include/c.h
index a5162b964..8a67b5dfb 100644
--- a/include/c.h
+++ b/include/c.h
@@ -77,6 +77,24 @@
 #endif
 
 /*
+ * Statement Attributes
+ */
+#if defined(__clang__)
+# ifndef __has_cpp_attribute
+#  define __has_cpp_attribute(x) 0
+# endif
+# if __has_cpp_attribute(clang::fallthrough)
+#  define UL_FALLTHROUGH [[clang::fallthrough]]
+# else
+#  define UL_FALLTHROUGH /* fall through */
+# endif
+#elif defined(__GNUC__) || defined(__GNUG__)
+# define UL_FALLTHROUGH __attribute__((fallthrough))
+#else
+# define UL_FALLTHROUGH /* FALLTHRU */
+#endif
+
+/*
  * Force a compilation error if condition is true, but also produce a
  * result (of value 0 and type size_t), so the expression can be used
  * e.g. in a structure initializer (or wherever else comma expressions
diff --git a/libblkid/src/topology/md.c b/libblkid/src/topology/md.c
index 5eba94787..7081d8993 100644
--- a/libblkid/src/topology/md.c
+++ b/libblkid/src/topology/md.c
@@ -121,11 +121,11 @@ static int probe_md_tp(blkid_probe pr,
 	switch (md.level) {
 	case 6:
 		md.raid_disks--;
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case 5:
 	case 4:
 		md.raid_disks--;
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case 1:
 	case 0:
 	case 10:
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 8cd737c8b..691a4b2f8 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -1412,7 +1412,7 @@ static int initialize_printing(struct libscols_table *tb, struct libscols_buffer
 	case SCOLS_FMT_JSON:
 		if (tb->format == SCOLS_FMT_JSON)
 			extra_bufsz += tb->nlines * 3;		/* indention */
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case SCOLS_FMT_EXPORT:
 	{
 		struct libscols_column *cl;
diff --git a/login-utils/last.c b/login-utils/last.c
index f93ec7fbf..ad23c986a 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -830,7 +830,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 					c = whydown;
 				quit = list(ctl, &ut, lastboot, c);
 			}
-			/* FALLTHRU */
+			UL_FALLTHROUGH;
 
 		case DEAD_PROCESS:
 			/*
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index ab04c10bb..ec3a966cd 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -926,13 +926,13 @@ static struct libscols_table *setup_table(struct lslogins_control *ctl)
 		break;
 	case OUT_NEWLINE:
 		scols_table_set_column_separator(table, "\n");
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case OUT_EXPORT:
 		scols_table_enable_export(table, 1);
 		break;
 	case OUT_NUL:
 		scols_table_set_line_separator(table, "\0");
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case OUT_RAW:
 		scols_table_enable_raw(table, 1);
 		break;
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 0999795c8..9fae8f105 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -899,6 +899,7 @@ su_main (int argc, char **argv, int mode)
     /* fallthrough if -u <user> is not specified, then follow
      * traditional su(1) behavior
      */
+     UL_FALLTHROUGH;
   case SU_MODE:
     if (optind < argc)
       new_user = argv[optind++];
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 2487838e7..36468ef0b 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -267,11 +267,11 @@ static void tcfinal(struct console *con)
 		break;
 	case 1:				/* odd parity */
 		tio->c_cflag |= PARODD;
-		/* fall through */
+		UL_FALLTHROUGH;
 	case 2:				/* even parity */
 		tio->c_cflag |= PARENB;
 		tio->c_iflag |= (INPCK | ISTRIP);
-		/* fall through */
+		UL_FALLTHROUGH;
 	case (1 | 2):			/* no parity bit */
 		tio->c_cflag &= ~CSIZE;
 		tio->c_cflag |= CS7;
@@ -971,7 +971,6 @@ int main(int argc, char **argv)
 		switch ((con->pid = fork())) {
 		case 0:
 			mask_signal(SIGCHLD, SIG_DFL, NULL);
-			/* fall through */
 		nofork:
 			setup(con);
 			while (1) {
@@ -1024,7 +1023,7 @@ int main(int argc, char **argv)
 			exit(0);
 		case -1:
 			warn(_("fork failed"));
-			/* fall through */
+			UL_FALLTHROUGH;
 		default:
 			break;
 		}
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 604eb26a7..d20ec7f89 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -431,7 +431,7 @@ int main(int argc, char **argv)
 		ctl.req.day = strtos32_or_err(*argv++, _("illegal day value"));
 		if (ctl.req.day < 1 || DAYS_IN_MONTH < ctl.req.day)
 			errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), DAYS_IN_MONTH);
-		/* FALLTHROUGH */
+		UL_FALLTHROUGH;
 	case 2:
 		if (isdigit(**argv))
 			ctl.req.month = strtos32_or_err(*argv++, _("illegal month value: use 1-12"));
@@ -443,7 +443,7 @@ int main(int argc, char **argv)
 		}
 		if (ctl.req.month < 1 || MONTHS_IN_YEAR < ctl.req.month)
 			errx(EXIT_FAILURE, _("illegal month value: use 1-12"));
-		/* FALLTHROUGH */
+		UL_FALLTHROUGH;
 	case 1:
 		ctl.req.year = strtos32_or_err(*argv++, _("illegal year value"));
 		if (ctl.req.year < SMALLEST_YEAR)
@@ -802,10 +802,10 @@ static void monthly(const struct cal_control *ctl)
 			switch (ctl->num_months % ctl->months_in_row){
 				case 1:
 					m1.next = NULL;
-					/* fallthrough */
+					UL_FALLTHROUGH;
 				case 2:
 					m2.next = NULL;
-					/* fallthrough */
+					UL_FALLTHROUGH;
 			}
 		}
 		for (m = &m1; m; m = m->next){
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 86b6b9aa1..5b8d345b1 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1458,7 +1458,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'M':
 			flags |= FL_STRICTTARGET;
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case 'T':
 			set_match(COL_TARGET, optarg);
 			flags |= FL_NOSWAPMATCH;
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 79077af07..7a3038cc9 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1847,7 +1847,7 @@ int main(int argc, char *argv[])
 			lsblk->sort_id = column_name_to_id(optarg, strlen(optarg));
 			if (lsblk->sort_id >= 0)
 				break;
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 65ac543ef..a7671fa11 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -174,7 +174,7 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'n':
 			noact = 1;
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		case 'o':
 			nooverwrite = 1;
                         break;
@@ -189,7 +189,6 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
-			/* fallthrough */
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 8af1e8ade..3fd2d8ad7 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -305,7 +305,7 @@ int main(int argc, char *argv[])
 				if (open_flags & O_RDWR)
 					break;
 			}
-			/* go through */
+			UL_FALLTHROUGH;
 		default:
 			/* Other errors */
 			if (filename)
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 603146079..c76f25d2e 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1209,7 +1209,8 @@ static void out_version(void)
  * fmt, ... ), show a usage information and terminate the program
  * afterwards.
  */
-static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
+static void __attribute__((__noreturn__))
+usage(const struct hwclock_control *ctl, const char *fmt, ...)
 {
 	FILE *usageto;
 	va_list ap;
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 0432b224f..f24e2f1ee 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -346,6 +346,7 @@ int main(int argc, char **argv)
 				ret++;
 				break;
 			}
+			UL_FALLTHROUGH;
 		case 'm':
 			if (!iskey)
 				id = strtos32_or_err(optarg, _("failed to parse argument"));
@@ -359,6 +360,7 @@ int main(int argc, char **argv)
 				ret++;
 				break;
 			}
+			UL_FALLTHROUGH;
 		case 'q':
 			if (!iskey)
 				id = strtos32_or_err(optarg, _("failed to parse argument"));
@@ -372,6 +374,7 @@ int main(int argc, char **argv)
 				ret++;
 				break;
 			}
+			UL_FALLTHROUGH;
 		case 's':
 			if (!iskey)
 				id = strtos32_or_err(optarg, _("failed to parse argument"));
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 3e7586b32..6ec192ef6 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -343,7 +343,7 @@ static struct libscols_table *new_table(struct lsipc_control *ctl)
 	switch(ctl->outmode) {
 	case OUT_NEWLINE:
 		scols_table_set_column_separator(table, "\n");
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case OUT_EXPORT:
 		scols_table_enable_export(table, 1);
 		break;
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index afa1b9c50..6ad0b0fe0 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -65,7 +65,7 @@ static struct namespace_file {
 	{ .nstype = 0, .name = NULL, .fd = -1 }
 };
 
-static void usage(int status)
+static void __attribute__((__noreturn__)) usage(int status)
 {
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
 
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index eb9cf21a0..94d9413d8 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -377,7 +377,7 @@ int main(int argc, char *argv[])
 				return EXIT_SUCCESS;
 			} else
 				warnx(_("unrecognized option '--list'"));
-			/* fallthrough */
+			UL_FALLTHROUGH;
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index bccd75f3a..6c5c2e2f9 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -238,7 +238,7 @@ static void bind_ns_files_from_child(pid_t *child, int fds[2])
 	}
 }
 
-static void usage(int status)
+static void __attribute__((__noreturn__)) usage(int status)
 {
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 93a3843c7..756343beb 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2041,12 +2041,12 @@ static void termio_final(struct options *op, struct termios *tp, struct chardata
 	case 1:
 		/* odd parity */
 		tp->c_cflag |= PARODD;
-		/* do not break */
+		UL_FALLTHROUGH;
 	case 2:
 		/* even parity */
 		tp->c_cflag |= PARENB;
 		tp->c_iflag |= INPCK | ISTRIP;
-		/* do not break */
+		UL_FALLTHROUGH;
 	case (1 | 2):
 		/* no parity bit */
 		tp->c_cflag &= ~CSIZE;
diff --git a/term-utils/script.c b/term-utils/script.c
index f2fc2f59c..ed7727ed9 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -389,9 +389,9 @@ static void handle_signal(struct script_control *ctl, int fd)
 		}
 		break;
 	case SIGTERM:
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case SIGINT:
-		/* fallthrough */
+		UL_FALLTHROUGH;
 	case SIGQUIT:
 		DBG(SIGNAL, ul_debug(" get signal SIG{TERM,INT,QUIT}"));
 		fprintf(stderr, _("\nSession terminated.\n"));
diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index c60a4d06b..799877704 100644
--- a/text-utils/hexdump-parse.c
+++ b/text-utils/hexdump-parse.c
@@ -351,7 +351,7 @@ isint:				cs[3] = '\0';
 					case 'A':
 						endfu = fu;
 						fu->flags |= F_IGNORE;
-						/* FALLTHROUGH */
+						UL_FALLTHROUGH;
 					case 'a':
 						pr->flags = F_ADDRESS;
 						++p2;
diff --git a/text-utils/more.c b/text-utils/more.c
index 72dd96bf4..4a358850a 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1270,7 +1270,7 @@ int command(char *filename, register FILE *f)
 				break;
 			}
 			lastp++;
-			/* fall through */
+			UL_FALLTHROUGH;
 		case '/':
 			if (nlines == 0)
 				nlines++;
@@ -1368,7 +1368,7 @@ int command(char *filename, register FILE *f)
 						(char *)0);
 				break;
 			}
-			/* fall through */
+			UL_FALLTHROUGH;
 		default:
 			if (dum_opt) {
 				kill_line();
@@ -2023,6 +2023,7 @@ int expand(char **outbuf, char *inbuf)
 				*outstr++ = *inpstr++;
 				break;
 			}
+			UL_FALLTHROUGH;
 		default:
 			*outstr++ = c;
 		}
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 1b9b8d7dd..7608a0c45 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -659,7 +659,7 @@ static void prompt(long long pageno)
 					break;
 				case SEARCH_FIN:
 					state = SEARCH;
-					/* FALLTHRU */
+					UL_FALLTHROUGH;
 				case SEARCH:
 					if (cmd.cmdline[cmd.cmdlen - 1] == '\\') {
 						escape = 1;
@@ -738,7 +738,7 @@ static void prompt(long long pageno)
 					continue;
 				}
 				state = COUNT;
-				/* FALLTHRU */
+				UL_FALLTHROUGH;
 			case COUNT:
 				break;
 			case ADDON_FIN:
diff --git a/text-utils/ul.c b/text-utils/ul.c
index 3986b4206..79e6bdbc5 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -208,7 +208,7 @@ int main(int argc, char **argv)
 
 	default:
 		warnx(_("trouble reading terminfo"));
-		/* fall through to ... */
+		UL_FALLTHROUGH;
 
 	case 0:
 		if (tflag)
@@ -317,7 +317,7 @@ static void filter(FILE *f)
 			}
 			obuf[col].c_char = '_';
 			obuf[col].c_width = 1;
-			/* fall through */
+			UL_FALLTHROUGH;
 		case ' ':
 			setcol(col + 1);
 			continue;
-- 
2.13.1


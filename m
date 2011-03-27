Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61878 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab1C0QaX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Mar 2011 12:30:23 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2260978wya.19
        for <util-linux@vger.kernel.org>; Sun, 27 Mar 2011 09:30:23 -0700 (PDT)
From: =?UTF-8?q?Olivier=20Mengu=C3=A9?= <dolmen@cpan.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Olivier=20Mengu=C3=A9?= <dolmen@cpan.org>
Subject: [PATCH] getopt: [getopt.c] add static qualifiers
Date: Sun, 27 Mar 2011 18:29:56 +0200
Message-Id: <1301243396-26240-2-git-send-email-dolmen@cpan.org>
In-Reply-To: <1301243396-26240-1-git-send-email-dolmen@cpan.org>
References: <1301243396-26240-1-git-send-email-dolmen@cpan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Olivier Mengué <dolmen@cpan.org>
---
 getopt/getopt.c |   52 ++++++++++++++++++++++++++--------------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/getopt/getopt.c b/getopt/getopt.c
index cea2f22..2e7109d 100644
--- a/getopt/getopt.c
+++ b/getopt/getopt.c
@@ -59,27 +59,27 @@ typedef enum {BASH,TCSH} shell_t;
 
 
 /* Some global variables that tells us how to parse. */
-shell_t shell=BASH; /* The shell we generate output for. */
-int quiet_errors=0; /* 0 is not quiet. */
-int quiet_output=0; /* 0 is not quiet. */
-int quote=1; /* 1 is do quote. */
-int alternative=0; /* 0 is getopt_long, 1 is getopt_long_only */
+static shell_t shell=BASH; /* The shell we generate output for. */
+static int quiet_errors=0; /* 0 is not quiet. */
+static int quiet_output=0; /* 0 is not quiet. */
+static int quote=1; /* 1 is do quote. */
+static int alternative=0; /* 0 is getopt_long, 1 is getopt_long_only */
 
 /* Function prototypes */
-void *our_malloc(size_t size);
-void *our_realloc(void *ptr, size_t size);
-const char *normalize(const char *arg);
-int generate_output(char * argv[],int argc,const char *optstr,
-                    const struct option *longopts);
+static void *our_malloc(size_t size);
+static void *our_realloc(void *ptr, size_t size);
+static const char *normalize(const char *arg);
+static int generate_output(char * argv[],int argc,const char *optstr,
+                           const struct option *longopts);
 int main(int argc, char *argv[]);
-void parse_error(const char *message);
-void add_long_options(char *options);
-void add_longopt(const char *name,int has_arg);
-void print_help(void);
-void set_shell(const char *new_shell);
-void set_initial_shell(void);
-
-void *our_malloc(size_t size)
+static void parse_error(const char *message);
+static void add_long_options(char *options);
+static void add_longopt(const char *name,int has_arg);
+static void print_help(void);
+static void set_shell(const char *new_shell);
+static void set_initial_shell(void);
+
+static void *our_malloc(size_t size)
 {
 	void *ret=malloc(size);
 	if (! ret) {
@@ -89,7 +89,7 @@ void *our_malloc(size_t size)
 	return(ret);
 }
 
-void *our_realloc(void *ptr, size_t size)
+static void *our_realloc(void *ptr, size_t size)
 {
 	void *ret=realloc(ptr,size);
 	if (! ret && size) {
@@ -108,7 +108,7 @@ void *our_realloc(void *ptr, size_t size)
  * This function returns a pointer to a buffer that is overwritten by 
  * each call.
  */
-const char *normalize(const char *arg)
+static const char *normalize(const char *arg)
 {
 	static char *BUFFER=NULL;
 	const char *argptr=arg;
@@ -172,8 +172,8 @@ const char *normalize(const char *arg)
  * optstr must contain the short options, and longopts the long options.
  * Other settings are found in global variables.
  */
-int generate_output(char * argv[],int argc,const char *optstr,
-                    const struct option *longopts)
+static int generate_output(char * argv[],int argc,const char *optstr,
+                           const struct option *longopts)
 {
 	int exit_code = 0; /* We assume everything will be OK */
 	int opt;
@@ -222,7 +222,7 @@ int generate_output(char * argv[],int argc,const char *optstr,
  * If message is NULL, we already sent a message, we just exit with a helpful
  * hint.
  */
-void parse_error(const char *message)
+static void parse_error(const char *message)
 {
 	if (message)
 		fprintf(stderr,"getopt: %s\n",message);
@@ -237,7 +237,7 @@ static int long_options_nr=0; /* Nr of used elements in array */
 #define init_longopt() add_longopt(NULL,0)
 
 /* Register a long option. The contents of name is copied. */
-void add_longopt(const char *name,int has_arg)
+static void add_longopt(const char *name,int has_arg)
 {
 	char *tmp;
 	if (!name) { /* init */
@@ -276,7 +276,7 @@ void add_longopt(const char *name,int has_arg)
  * separated by commas or whitespace. 
  * This nukes options! 
  */
-void add_long_options(char *options)
+static void add_long_options(char *options)
 {
 	int arg_opt;
 	char *tokptr=strtok(options,", \t\n");
@@ -301,7 +301,7 @@ void add_long_options(char *options)
 	}
 }
 
-void set_shell(const char *new_shell)
+static void set_shell(const char *new_shell)
 {
 	if (!strcmp(new_shell,"bash"))
 		shell=BASH;
@@ -315,7 +315,7 @@ void set_shell(const char *new_shell)
 		parse_error(_("unknown shell after -s or --shell argument"));
 }
 
-void print_help(void)
+static void print_help(void)
 {
 	fputs(_("Usage: getopt optstring parameters\n"),stderr);
 	fputs(_("       getopt [options] [--] optstring parameters\n"),stderr);
-- 
1.7.1


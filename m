Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:50398 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3JGWEz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Oct 2013 18:04:55 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so7990523wgh.30
        for <util-linux@vger.kernel.org>; Mon, 07 Oct 2013 15:04:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] various: fix mixing declarations and code compiler warnings [smatch]
Date: Mon,  7 Oct 2013 23:04:23 +0100
Message-Id: <1381183463-1297-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
References: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/dos.c           |  6 +++---
 libmount/python/pylibmount.c |  3 ++-
 libmount/python/tab.c        |  3 ++-
 term-utils/mesg.c            | 10 +++++-----
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index d9b1e74..d93e44b 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1180,9 +1180,9 @@ static int dos_verify_disklabel(struct fdisk_context *cxt)
 	}
 
 	if (l->ext_offset) {
+		sector_t e_last;
 		p = self_partition(cxt, l->ext_index);
-
-		sector_t e_last = dos_partition_get_start(p)
+		e_last = dos_partition_get_start(p)
 				  + dos_partition_get_size(p) - 1;
 
 		for (i = 4; i < cxt->label->nparts_max; i++) {
@@ -1612,7 +1612,7 @@ static int dos_list_disklabel(struct fdisk_context *cxt)
 	for (i = 0; i < cxt->label->nparts_max; i++) {
 		struct pte *pe = self_pte(cxt, i);
 		struct dos_partition *p = pe->pt_entry;
-		unsigned int psects, pblocks, podd = 0;;
+		unsigned int psects, pblocks, podd = 0;
 		struct fdisk_parttype *type;
 		struct tt_line *ln;
 		char *str;
diff --git a/libmount/python/pylibmount.c b/libmount/python/pylibmount.c
index 1403bfe..c538bb5 100644
--- a/libmount/python/pylibmount.c
+++ b/libmount/python/pylibmount.c
@@ -90,6 +90,7 @@ PyObject *PyObjectResultInt(int i)
 
 PyObject *PyObjectResultStr(const char *s)
 {
+	PyObject *result;
 	if (!s)
 		/* TODO: maybe lie about it and return "":
 		 * which would allow for
@@ -97,7 +98,7 @@ PyObject *PyObjectResultStr(const char *s)
 		 * fs.comment += "comment"
 		return Py_BuildValue("s", ""); */
 		Py_RETURN_NONE;
-	PyObject *result = Py_BuildValue("s", s);
+	result = Py_BuildValue("s", s);
 	if (!result)
 		PyErr_SetString(PyExc_RuntimeError, CONSTRUCT_ERR);
 	return result;
diff --git a/libmount/python/tab.c b/libmount/python/tab.c
index 9ea6924..6f255ae 100644
--- a/libmount/python/tab.c
+++ b/libmount/python/tab.c
@@ -600,9 +600,10 @@ static int Table_init(TableObject *self, PyObject *args, PyObject *kwds)
 		self->iter = mnt_new_iter(MNT_ITER_FORWARD);
 
 	if (errcb) {
+		PyObject *tmp;
 		if (!PyCallable_Check(errcb))
 			return -1;
-		PyObject *tmp = self->errcb;
+		tmp = self->errcb;
 		Py_INCREF(errcb);
 		self->errcb = errcb;
 		Py_XDECREF(tmp);
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 097fb9c..12e4e0e 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -88,11 +88,6 @@ int main(int argc, char *argv[])
 	char *tty;
 	int ch, verbose = FALSE;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
 	static const struct option longopts[] = {
 		{ "verbose",    no_argument,       0, 'v' },
 		{ "version",    no_argument,       0, 'V' },
@@ -100,6 +95,11 @@ int main(int argc, char *argv[])
 		{ NULL,         0, 0, 0 }
 	};
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
 	while ((ch = getopt_long(argc, argv, "vVh", longopts, NULL)) != -1)
 		switch (ch) {
 		case 'v':
-- 
1.8.4


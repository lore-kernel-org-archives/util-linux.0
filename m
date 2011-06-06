Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFTHj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:39 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1471009ewy.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/6] sfdisk: fix for data type mismatches
Date: Mon,  6 Jun 2011 21:07:19 +0200
Message-Id: <1307387239-9022-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index afecb93..d761032 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1409,7 +1409,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 
 	cp = s->data + 0x1be;
 
-	if (pno+4 >= ARRAY_SIZE(z->partitions)) {
+	if ((unsigned long) pno+4 >= ARRAY_SIZE(z->partitions)) {
 	    do_warn(_("too many partitions - ignoring those past nr (%d)\n"),
 		   pno-1);
 	    break;
@@ -1486,7 +1486,7 @@ bsd_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z) {
 
 	bp = bp0 = &l->d_partitions[0];
 	while (bp - bp0 < BSD_MAXPARTITIONS && bp - bp0 < l->d_npartitions) {
-		if (pno+1 >= ARRAY_SIZE(z->partitions)) {
+		if ((unsigned long) pno+1 >= ARRAY_SIZE(z->partitions)) {
 			do_warn(_("too many partitions - ignoring those "
 			       "past nr (%d)\n"), pno-1);
 			break;
@@ -1762,7 +1762,7 @@ read_stdin(char **fields, char *line, int fieldssize, int linesize) {
 	      ip++;
 	    if (*ip == 0)
 	      return fno;
-	    for(d = dumpflds; d-dumpflds < ARRAY_SIZE(dumpflds); d++) {
+	    for(d = dumpflds; d-dumpflds < (long) ARRAY_SIZE(dumpflds); d++) {
 		if (!strncmp(ip, d->fldname, strlen(d->fldname))) {
 		    ip += strlen(d->fldname);
 		    while(isspace(*ip))
@@ -1957,7 +1957,7 @@ compute_start_sect(struct part_desc *p, struct part_desc *ep) {
 	p->size += delta;
 	if (is_extended(p->p.sys_type) && boxes == ONESECTOR)
 	  p->size = inc;
-	else if (old_size <= -delta) {
+	else if ((ssize_t) old_size <= (ssize_t) -delta) {
 	    my_warn(_("no room for partition descriptor\n"));
 	    return 0;
 	}
@@ -2256,7 +2256,7 @@ read_partition_chain(char *dev, int interactive, struct part_desc *ep,
     eob = 0;
     while (1) {
 	base = z->partno;
-	if (base+4 > ARRAY_SIZE(z->partitions)) {
+	if ((unsigned long) base+4 > ARRAY_SIZE(z->partitions)) {
 	    do_warn(_("too many partitions\n"));
 	    break;
 	}
@@ -2285,7 +2285,7 @@ read_input(char *dev, int interactive, struct disk_desc *z) {
     int i;
     struct part_desc *partitions = &(z->partitions[0]), *ep;
 
-    for (i=0; i < ARRAY_SIZE(z->partitions); i++)
+    for (i=0; (unsigned long) i < ARRAY_SIZE(z->partitions); i++)
       partitions[i] = zero_part_desc;
     z->partno = 0;
 
-- 
1.7.5.2


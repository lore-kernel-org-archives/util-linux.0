Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:44420 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754178Ab2EFTCs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 15:02:48 -0400
Subject: Re: [PATCH 3/5] fdisk: create DOS specific write table function
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120506181144.GB6429@skipper.site>
References: <1336306221.2685.12.camel@offbook>
	 <20120506181144.GB6429@skipper.site>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 21:02:45 +0200
Message-ID: <1336330965.2685.20.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2012-05-06 at 20:11 +0200, Petr Uzel wrote:
> On Sun, May 06, 2012 at 02:10:21PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisk/fdisk.c         |   27 ++++-----------------------
> >  fdisk/fdiskdoslabel.c |   27 +++++++++++++++++++++++++++
> >  fdisk/fdiskdoslabel.h |    1 +
> >  3 files changed, 32 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> > index 8c2a162..3044879 100644
> > --- a/fdisk/fdisk.c
> > +++ b/fdisk/fdisk.c
> > @@ -1672,31 +1672,12 @@ static void
> >  write_table(void) {
> >  	int i;
> >  
> > -	if (disklabel == DOS_LABEL) {
> > -		/* MBR (primary partitions) */
> > -		if (!MBRbuffer_changed) {
> > -			for (i = 0; i < 4; i++)
> > -				if (ptes[i].changed)
> > -					MBRbuffer_changed = 1;
> > -		}
> > -		if (MBRbuffer_changed) {
> > -			write_part_table_flag(MBRbuffer);
> > -			write_sector(fd, 0, MBRbuffer);
> > -		}
> > -		/* EBR (logical partitions) */
> > -		for (i = 4; i < partitions; i++) {
> > -			struct pte *pe = &ptes[i];
> > -
> > -			if (pe->changed) {
> > -				write_part_table_flag(pe->sectorbuffer);
> > -				write_sector(fd, pe->offset, pe->sectorbuffer);
> > -			}
> > -		}
> > -	}
> > -	else if (disklabel == SGI_LABEL) {
> > +	if (disklabel == DOS_LABEL)
> > +		dos_write_table();
> > +	else if (disklabel == SGI_LABEL)
> >  		/* no test on change? the printf below might be mistaken */
> >  		sgi_write_table();
> > -	} else if (disklabel == SUN_LABEL) {
> > +	else if (disklabel == SUN_LABEL) {
> >  		int needw = 0;
> >  
> >  		for (i=0; i<8; i++)
> > diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
> > index 3f820db..a13a83a 100644
> > --- a/fdisk/fdiskdoslabel.c
> > +++ b/fdisk/fdiskdoslabel.c
> > @@ -657,3 +657,30 @@ void dos_new_partition(void)
> >  			printf(_("Invalid partition type `%c'\n"), c);
> >  	}
> >  }
> > +
> > +void dos_write_table(void)
> > +{
> > +	int i;
> > +
> > +	if (disklabel == DOS_LABEL) {
> 
> This if is unnecessary - the caller should make sure that
> disklabel == DOS_LABEL as write_table() does. What about
> 
> assert(disklabel == DOS_LABEL) instead?

Absolutely right. I don't think we even need an assert here since this
is only called from DOS context and fdisk.c does that check - plus no
other functions or labels do it anyway.

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 6 May 2012 21:00:16 +0200
Subject: [PATCH] fdisk: create DOS specific write table function

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |   27 ++++-----------------------
 fdisk/fdiskdoslabel.c |   25 +++++++++++++++++++++++++
 fdisk/fdiskdoslabel.h |    1 +
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 8c2a162..3044879 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1672,31 +1672,12 @@ static void
 write_table(void) {
 	int i;
 
-	if (disklabel == DOS_LABEL) {
-		/* MBR (primary partitions) */
-		if (!MBRbuffer_changed) {
-			for (i = 0; i < 4; i++)
-				if (ptes[i].changed)
-					MBRbuffer_changed = 1;
-		}
-		if (MBRbuffer_changed) {
-			write_part_table_flag(MBRbuffer);
-			write_sector(fd, 0, MBRbuffer);
-		}
-		/* EBR (logical partitions) */
-		for (i = 4; i < partitions; i++) {
-			struct pte *pe = &ptes[i];
-
-			if (pe->changed) {
-				write_part_table_flag(pe->sectorbuffer);
-				write_sector(fd, pe->offset, pe->sectorbuffer);
-			}
-		}
-	}
-	else if (disklabel == SGI_LABEL) {
+	if (disklabel == DOS_LABEL)
+		dos_write_table();
+	else if (disklabel == SGI_LABEL)
 		/* no test on change? the printf below might be mistaken */
 		sgi_write_table();
-	} else if (disklabel == SUN_LABEL) {
+	else if (disklabel == SUN_LABEL) {
 		int needw = 0;
 
 		for (i=0; i<8; i++)
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 3f820db..4e12d94 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -657,3 +657,28 @@ void dos_new_partition(void)
 			printf(_("Invalid partition type `%c'\n"), c);
 	}
 }
+
+void dos_write_table(void)
+{
+	int i;
+	
+	/* MBR (primary partitions) */
+	if (!MBRbuffer_changed) {
+		for (i = 0; i < 4; i++)
+			if (ptes[i].changed)
+				MBRbuffer_changed = 1;
+	}
+	if (MBRbuffer_changed) {
+		write_part_table_flag(MBRbuffer);
+		write_sector(fd, 0, MBRbuffer);
+	}
+	/* EBR (logical partitions) */
+	for (i = 4; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (pe->changed) {
+			write_part_table_flag(pe->sectorbuffer);
+			write_sector(fd, pe->offset, pe->sectorbuffer);
+		}
+	}
+}
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index e45a026..8c116f7 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -52,5 +52,6 @@ extern int is_dos_partition(int t);
 extern void dos_init(void);
 extern void dos_add_partition(int n, int sys);
 extern void dos_new_partition(void);
+extern void dos_write_table(void);
 
 #endif
-- 
1.7.4.1




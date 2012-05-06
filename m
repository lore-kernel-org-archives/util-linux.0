Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:38456 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754079Ab2EFSxQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 14:53:16 -0400
Subject: Re: [PATCH 1/5] fdisk: remove unused hsc2sector macro
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120506173408.GA14007@skipper.site>
References: <1336306216.2685.10.camel@offbook>
	 <20120506173408.GA14007@skipper.site>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 20:53:14 +0200
Message-ID: <1336330394.2685.16.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2012-05-06 at 19:34 +0200, Petr Uzel wrote:
> On Sun, May 06, 2012 at 02:10:16PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> > fdisk/fdisk.c |    2 --
> > 1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> > index dccaf27..3543745 100644
> > --- a/fdisk/fdisk.c
> > +++ b/fdisk/fdisk.c
> > @@ -68,8 +68,6 @@ int MBRbuffer_changed;
> > #define sector(s) ((s) & 0x3f)
> > #define cylinder(s, c) ((c) | (((s) & 0xc0) << 2))
> > 
> > -#define hsc2sector(h,s,c) (sector(s) - 1 + sectors * \
> > - ((h) + heads * cylinder(s,c)))
> > #define set_hsc(h,s,c,sector) { \
> > s = sector % sectors + 1; \
> > sector /= sectors; \
> 
> This patch seems to be malformed. Could you please check what's wrong?

Hmm perhaps my mail client did something stupid (or me :)

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 6 May 2012 20:51:37 +0200
Subject: [PATCH] fdisk: remove unused hsc2sector-macor

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index dccaf27..3543745 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -68,8 +68,6 @@ int MBRbuffer_changed;
 #define sector(s)	((s) & 0x3f)
 #define cylinder(s, c)	((c) | (((s) & 0xc0) << 2))
 
-#define hsc2sector(h,s,c) (sector(s) - 1 + sectors * \
-				((h) + heads * cylinder(s,c)))
 #define set_hsc(h,s,c,sector) { \
 				s = sector % sectors + 1;	\
 				sector /= sectors;	\
-- 
1.7.4.1




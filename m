Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbdEVL0j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 May 2017 07:26:39 -0400
Date: Mon, 22 May 2017 13:26:35 +0200
From: Karel Zak <kzak@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: "mount -o remount,rw" sometimes doesn't work as expected.
Message-ID: <20170522112635.bcnfvxuqi7xbifb5@ws.net.home>
References: <87wp9djp2n.fsf@notabene.neil.brown.name>
 <20170519091125.bdans7hirua3blb5@ws.net.home>
 <87r2zhkg8r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2zhkg8r.fsf@notabene.neil.brown.name>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 22, 2017 at 08:16:36AM +1000, NeilBrown wrote:
> oooh... it just occurred to me that for a mount, I can make it
> read/write by:
> 
>    mount -o remount,rw none /mount/point
> 
> providing I know that no other flags are needed.  I don't need to give
> the correct device path, do I?

Yes, "none" is an usable placeholder there.

> > After this call, mount reads fstab and merges these options with the
> > options from the command line (-o).  If no mountpoint is found in
> > fstab, then a remount with  unspecified source is allowed.
> 
> BTW, if fstab contains just
> 
>    /bar /foo none bind 0 0
> 
> 
> Then both
>   mount -o remount,rw /bar
> and
>   mount -o remount,rw /foo
> 
> will try to remount /foo.  This is also surprising....

Yes, mount(8) goal is to accept "whatever" to keep users happy :-)

This your example is well known disadvantage, the solution is to use
--source and --target options (it's strongly recommended for scripts):

   mount -o remount,rw --source /bar
   mount -o remount,rw --target /foo

in this case mount(8) will not try to be smart...

...

> >> You could possibly argue that the current behaviour is correct
> >> as /foo is listed as bind mount.  That doesn't stop is being surprising.
> >> Also
> >>    mount /bar /foo -o remount,rw
> >> 
> >> doesn't pick up the "bind" flag, so the filesystem gets remounted.
> >> So I think there is definitely something wrong.
> >
> > That's question... "remount,bind" is really special and maybe "bind"
> > from fstab should be really ignored in this case.
> 
> I think that is probably the best way forward, at least in the short
> term.
> I might try to dig into the code and see how easy this would be.

It's trivial patch, see below. Seems to work as expected (I use
"findmnt -o TARGET,VFS-OPTIONS,FS-OPTION" to see ro/rw).

    Karel


diff --git a/libmount/src/context.c b/libmount/src/context.c
index 38e0363..a574758 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -2038,7 +2038,7 @@ static int apply_table(struct libmnt_context *cxt, struct libmnt_table *tb,
  */
 int mnt_context_apply_fstab(struct libmnt_context *cxt)
 {
-	int rc = -1, isremount = 0;
+	int rc = -1, isremount = 0, iscmdbind = 0;
 	struct libmnt_table *tab = NULL;
 	const char *src = NULL, *tgt = NULL;
 	unsigned long mflags = 0;
@@ -2063,8 +2063,10 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 		cxt->optsmode &= ~MNT_OMODE_FORCE;
 	}
 
-	if (mnt_context_get_mflags(cxt, &mflags) == 0 && mflags & MS_REMOUNT)
-		isremount = 1;
+	if (mnt_context_get_mflags(cxt, &mflags) == 0) {
+		isremount = !!(mflags & MS_REMOUNT);
+		iscmdbind = !!(mflags & MS_BIND);
+	}
 
 	if (cxt->fs) {
 		src = mnt_fs_get_source(cxt->fs);
@@ -2131,6 +2133,12 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 		 * not found are not so important and may be misinterpreted by
 		 * applications... */
 		rc = -MNT_ERR_NOFSTAB;
+
+
+	} else if (isremount && !iscmdbind) {
+
+		/* remove "bind" from fstab (or no-op if not present) */
+		mnt_optstr_remove_option(&cxt->fs->optstr, "bind");
 	}
 	return rc;
 }



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

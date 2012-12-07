Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48292 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab2LGRBV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Dec 2012 12:01:21 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so587722vcd.19
        for <util-linux@vger.kernel.org>; Fri, 07 Dec 2012 09:01:20 -0800 (PST)
Date: Fri, 7 Dec 2012 12:01:18 -0500
From: Dave Reisner <d@falconindy.com>
To: Werner Fink <werner@suse.de>, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>
Subject: Re: [util-linux] [PATCH 4/5] sulogin: mount temporary /dev and /proc
 if not found
Message-ID: <20121207170118.GG603@rampage>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
 <1354867258-14206-4-git-send-email-werner@suse.de>
 <20121207141709.GF603@rampage>
 <20121207154917.GA24191@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121207154917.GA24191@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 04:49:17PM +0100, Dr. Werner Fink wrote:
> On Fri, Dec 07, 2012 at 09:17:09AM -0500, Dave Reisner wrote:
> > On Fri, Dec 07, 2012 at 09:00:57AM +0100, Werner Fink wrote:
> > > +# define dovoid(f)	if ((f)){}
> > > +static __attribute__((__constructor__)) void getmounts(void)
> > > +{
> > > +	struct statfs st;
> > > +	if (statfs("/proc", &st) == 0 && st.f_type != PROC_SUPER_MAGIC) {
> > 
> > Why not use the standard mountpoint check -- compare the devno with / ?
> > 
> > > +		if (mount("proc", "/proc", "proc", MS_RELATIME, NULL) == 0)
> > > +			mounts |= MNT_PROCFS;
> > > +	}
> > > +	if (statfs("/dev", &st) == 0 && st.f_type != TMPFS_MAGIC) {
> > > +		if (mount("devtmpfs", "/dev", "devtmpfs", MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
> > > +			mounts |= MNT_DEVTMPFS;
> > 
> > Isn't all the work below here redundant? devtmpfs provides these
> > things.
> > 
> > > +			(void)mknod("/dev/console", S_IFCHR|S_IRUSR|S_IWUSR, makedev(TTYAUX_MAJOR, 1));
> > > +			if (symlink("/proc/self/fd", "/dev/fd") == 0) {
> > > +				dovoid(symlink("fd/0", "/dev/stdin"));
> > > +				dovoid(symlink("fd/1", "/dev/stdout"));
> > > +				dovoid(symlink("fd/2", "/dev/stderr"));
> > > +			}
> > > +		}
> > > +	}
> > > +	if (mounts) atexit(putmounts);
> > > +}
> > > +# undef dovoid
> > > +#endif
> > > +
> > >  static void usage(FILE *out)
> > >  {
> > >  	fputs(USAGE_HEADER, out);
> 
> We're talking about the very early boot stage, there is no udev nor anything else
> and the I've choosen this as this had worked very well in initrd where it had crashed
> before.  I do not say that there is no other way to do this but this way it works and
> the links I've done had been missed.

Ok, I didn't realize udev still was responsible for these links these
days, but perusing the code shows otherwise. Could you explain why
sulogin is wanted in the initramfs? Seems like an odd use case to me.

> If in initrd the sulogin will be called after mounting /proc and /dev and running
> udev rules or enabling the links in initrd then the code does only check for existence
> of /proc and /dev.

If you're in the initramfs, rootfs is tmpfs. Won't your statfs check
return a buffer which has f_type == TMPFS_MAGIC even if /dev is not
mounted?

>   Werner
> 
> -- 
>   "Having a smoking section in a restaurant is like having
>           a peeing section in a swimming pool." -- Edward Burr
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbDBIUI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 04:20:08 -0400
Date: Thu, 2 Apr 2015 10:20:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150402082000.GC2097@ws.net.home>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402011230.GA22171@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 01, 2015 at 09:12:30PM -0400, Mike Frysinger wrote:
> On 01 Apr 2015 23:38, Karel Zak wrote:
> > On Wed, Apr 01, 2015 at 10:06:52PM +0100, Ruediger Meier wrote:
> > > > > Maybe both cases also with or without fallback $sbindir, /sbin or
> > > > > $PATH.
> > > > >
> > > > > I guess we should agree how somthing like this should be handeled
> > > > > in general. "eject" is also using hardcoded "/bin/umount".
> > > >
> > > > seems like $PATH should always be used.  if you broke $PATH, well
> > 
> > Yes, agree.
> >  
> > Note that we already have and use FS_SEARCH_PATH in mkfs, fsck and
> > mount (libmount), see --enable-fs-paths-default and  --enable-fs-paths-extra.
> 
> what's the reason for having FS_SEARCH_PATH anymore ? 

If I good remember then the reason is that the helpers does not have
to be installed in standard PATH. Well, you're author of this thing
:-)

        commit bb4cb69df2a7fba3098f073aa4b758a8011d826f
        Author: Mike Frysinger <vapier@gentoo.org>
        Date:   Sun Jan 24 22:36:55 2010 -0500

        fsck/mkfs/mount: unify default search paths for helpers


> neither tool is set*id, 
> and mkfs/fsck generally live in /sbin.  i guess if you're non-root and have 
> /sbin/mkfs hardcoded in a script, then dropping FS_SEARCH_PATH might break 
> existing code.

for systemd based distors the path should be also modified, we have
all in /usr and /sbin and /bin are symlinks only.

> looking a bit at the code, i see that --disable-fs-paths-default almost does the 
> right thing.  but the actual implementations are inconsistent leading to 
> weirdness.
> 
> fsck adds / to the search:
> ...
> static const char fsck_prefix_path[] = FS_SEARCH_PATH;
> ...
>     char *oldpath = getenv("PATH");
> ...
>     if (oldpath) {
>         fsck_path = xmalloc (strlen (fsck_prefix_path) + 1 +
>                     strlen (oldpath) + 1);
>         strcpy (fsck_path, fsck_prefix_path);
>         strcat (fsck_path, ":");
>         strcat (fsck_path, oldpath);
> ...
>     tpl = (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");
> 
>     for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
>         sprintf(prog, tpl, s, type);
>         if (stat(prog, &st) == 0)
>             break;
>     }
> ...
> 
> mkfs adds the cwd to $PATH, and hardcodes /bin too:
> ...
> #define SEARCH_PATH "PATH=" FS_SEARCH_PATH
> ...
>     /* Set PATH and program name */
>     oldpath = getenv("PATH");
>     if (!oldpath)
>         oldpath = "/bin";
> 
>     newpath = xmalloc(strlen(oldpath) + sizeof(SEARCH_PATH) + 3);
>     sprintf(newpath, "%s:%s\n", SEARCH_PATH, oldpath);
>     putenv(newpath);
> ...
> 
> libmount only searches FS_SEARCH_PATH:
> ...
>     char search_path[] = FS_SEARCH_PATH;        /* from config.h */
> ...
>     path = strtok_r(search_path, ":", &p);
>     while (path) {
> ...
> 
> > Maybe we can use it use FS_SEARCH_PATH also for mkswap in swapon, or use it
> > as fallback.
> 
> my preference would be to not move more tools into that system and allow any 
> more implicit lookups to leak out.

I'm happy that for example mount(8) does not waste time with all PATH,
but it cares about /sbin only. IMHO it's fine that mkfs, mount and
fsck assume *helpers* on specific place. The mkswap is different, it's 
standard command and it's expected in PATH.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

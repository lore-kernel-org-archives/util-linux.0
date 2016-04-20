Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32866 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933315AbcDTKN2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Apr 2016 06:13:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so1702760wme.0
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2016 03:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160418102238.54gvnoxnsq7z76uv@ws.net.home>
References: <m3bn5lqdvi.fsf@gmail.com>
	<20160418102238.54gvnoxnsq7z76uv@ws.net.home>
Date: Wed, 20 Apr 2016 13:13:26 +0300
Message-ID: <CAMr-obvgiZagQLf0T6Mgx9XkFv3mTzhjZQkgE1V0si07rq73AA@mail.gmail.com>
Subject: Re: fsck -l: fix racing between unlock/unlink and open
From: Nir Soffer <nirsof@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 18, 2016 at 1:22 PM, Karel Zak <kzak@redhat.com> wrote:
>
> On Fri, Apr 08, 2016 at 12:59:29AM +0300, Yuriy M. Kaminskiy wrote:
> > Probably, there are better solutions, but I prefer KISS.
>
> > From fcb97ddcbc336bc8860828c47cdaf21c7b1ca655 Mon Sep 17 00:00:00 2001
> > From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
> > Date: Fri, 8 Apr 2016 00:38:56 +0300
> > Subject: [PATCH] fsck: fix racing between unlock/unlink and open
> >
> > Process A     Process B       Process C
> > open()
> > [creates file]
> > lock()
> > [succeed]
> >               open()
> >               [open existing]
> >               lock()...
> > running()
> > close()
> >               [...succeed]
> > unlink()
> >               running()
> >                               open()
> >                               [creates file] {BAD!}
> >                               lock()
> >                               [succeed] {BAD!}
> >                               running() {BAD!}
> >               close()
> >
>
> It would be better to check if the file still exist on the filesystem
> with the same inode number, if not then re-open. It means that on race
> you will create a new lock file. (You have to unlock after unlink.)
> See http://stackoverflow.com/questions/17708885/flock-removing-locked-file-without-race-condition
>
> Simple example:
>
> #include <stdio.h>
> #include <sys/file.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
>
> int main(int argc, char **argv)
> {
>         const char *lockpath = "test.lock";
>         int fd;
>         struct stat st_lock, st_file;
>
>         while (1) {
>                 fd = open(lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
>                                     S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
>                 fstat(fd, &st_lock);
>                 flock(fd, LOCK_EX);
>
>                 errno = 0;
>                 if (stat(lockpath, &st_file) == 0 && st_file.st_ino == st_lock.st_ino)
>                         break;
>                 if (errno)
>                         fprintf(stderr, "%d: stat failed: %m\n", getpid());
>                 else
>                         fprintf(stderr, "%d: ignore %lu (fs has:%lu)\n", getpid(), st_lock.st_ino, st_file.st_ino);
>                 close(fd);
>         }
>
>         fprintf(stderr, "%d: -->locked ino: %lu\n", getpid(), st_lock.st_ino);
>         sleep(10);
>         unlink(lockpath);
>         close(fd);
>         return 0;
> }
> See untested fsck patch below. Comments?

When multiple processes blocked on the same lock file, this
ensure that all of them will fail to validate the lock when flock
return, and will have to try again, but this is probably fine for
this use case.

>
>     Karel
>
>
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index 05cfbc4..0a7dbc8 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -370,23 +370,38 @@ static void lock_disk(struct fsck_instance *inst)
>         if (verbose)
>                 printf(_("Locking disk by %s ... "), inst->lockpath);
>
> -       inst->lock = open(inst->lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
> -                                   S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
> -       if (inst->lock >= 0) {
> -               int rc = -1;
> -
> -               /* inform users that we're waiting on the lock */
> -               if (verbose &&
> -                   (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
> -                   errno == EWOULDBLOCK)
> -                       printf(_("(waiting) "));
> -
> -               if (rc != 0 && flock(inst->lock, LOCK_EX) != 0) {
> -                       close(inst->lock);                      /* failed */
> -                       inst->lock = -1;
> +       while (1) {
> +               struct stat st_lock, st_file;

I would rename st_file to st_lockpath.

> +
> +               inst->lock = open(inst->lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
> +                                           S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
> +               if (inst->lock >= 0) {

We can replace this with

    if (inst->lock == -1)
        break;  /* failed */

Simplifying the normal flow, and eliminating the issue of
validating a lock after open failed.

> +                       int rc = -1;
> +
> +                       /* inform users that we're waiting on the lock */
> +                       if (verbose &&
> +                           (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
> +                           errno == EWOULDBLOCK)
> +                               printf(_("(waiting) "));
> +
> +                       if (rc != 0 && flock(inst->lock, LOCK_EX) != 0) {
> +                               close(inst->lock);                      /* failed */
> +                               inst->lock = -1;
> +                       }
>                 }
> +
> +               /*
> +                * Make sure the locked lockfile really exist on the filesystem
> +                * to avoid race between lock and unlink (see unlock_disk())
> +                */
> +               fstat(inst->lock, &st_lock);

This is going to fail when inst->lock == -1. Then the contents of
st_lock are random junk from the stack.

> +               if (stat(inst->lockpath, &st_file) == 0
> +                   && st_file.st_ino == st_lock.st_ino)

This check is relevant only if inst->lock >= 0

> +                       break;                          /* success */
> +               close(inst->lock);
>         }
>
> +
>         if (verbose)
>                 /* TRANSLATORS: These are followups to "Locking disk...". */
>                 printf("%s.\n", inst->lock >= 0 ? _("succeeded") : _("failed"));
> @@ -409,8 +424,8 @@ static void unlock_disk(struct fsck_instance *inst)
>         if (verbose)
>                 printf(_("Unlocking %s.\n"), inst->lockpath);
>
> -       close(inst->lock);                      /* unlock */

Here we should add a comment about the order and link to
lock_disk() depending on this order.

>         unlink(inst->lockpath);
> +       close(inst->lock);                      /* unlock */
>
>         free(inst->lockpath);

Nir

Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:36439 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbcDSO6V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Apr 2016 10:58:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1asX6Y-0007it-Mg
	for util-linux@vger.kernel.org; Tue, 19 Apr 2016 16:58:18 +0200
Received: from 95.131.151.139 ([95.131.151.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 16:58:18 +0200
Received: from yumkam by 95.131.151.139 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 16:58:18 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: fsck -l: fix racing between unlock/unlink and open
Date: Tue, 19 Apr 2016 17:58:11 +0300
Message-ID: <m3potlk5mk.fsf@gmail.com>
References: <m3bn5lqdvi.fsf@gmail.com>
	<20160418102238.54gvnoxnsq7z76uv@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Fri, Apr 08, 2016 at 12:59:29AM +0300, Yuriy M. Kaminskiy wrote:
>> Probably, there are better solutions, but I prefer KISS.
>
>> From fcb97ddcbc336bc8860828c47cdaf21c7b1ca655 Mon Sep 17 00:00:00 2001
>> From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
>> Date: Fri, 8 Apr 2016 00:38:56 +0300
>> Subject: [PATCH] fsck: fix racing between unlock/unlink and open
>> 
>> Process A	Process B	Process C
>> open()
>> [creates file]
>> lock()
>> [succeed]
>> 		open()
>> 		[open existing]
>> 		lock()...
>> running()
>> close()
>> 		[...succeed]
>> unlink()
>> 		running()
>> 				open()
>> 				[creates file] {BAD!}
>> 				lock()
>> 				[succeed] {BAD!}
>> 				running() {BAD!}
>> 		close()
>> 
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
> 	const char *lockpath = "test.lock";
> 	int fd;
> 	struct stat st_lock, st_file;
>
> 	while (1) {
> 		fd = open(lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
> 				    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
> 		fstat(fd, &st_lock);
> 		flock(fd, LOCK_EX);
>
> 		errno = 0;
> 		if (stat(lockpath, &st_file) == 0 && st_file.st_ino == st_lock.st_ino)
> 			break;

Requires stable inode numbers (well, probably acceptable assumption for {/var,}/run).

> 		if (errno)
> 			fprintf(stderr, "%d: stat failed: %m\n", getpid());
> 		else
> 			fprintf(stderr, "%d: ignore %lu (fs has:%lu)\n", getpid(), st_lock.st_ino, st_file.st_ino);
> 		close(fd);
> 	}
>
> 	fprintf(stderr, "%d: -->locked ino: %lu\n", getpid(), st_lock.st_ino);
> 	sleep(10);
> 	unlink(lockpath);
> 	close(fd);
> 	return 0;
> }
>
>
> See untested fsck patch below. Comments?

I still prefer KISS. (And I bet it will eat more resources than just
leaving those empty files around.)
(But either way, bug will be fixed, so I do as you like).

[...]


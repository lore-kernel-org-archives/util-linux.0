Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070271727
	for <util-linux@vger.kernel.org>; Thu, 18 Apr 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427600; cv=none; b=eYLzxJxZIYk3QzZYCb+gwUFT319ae6h8WQosWYCzFrFCErfE8oYOzW6N31UDgCAeBAmTCc69F0dL1brrHYMHMSyeEf/xBAKTyBOViSBi3xBCrrl12RXEt6s0/2xqgG+KzAjETuyJFH3JnwrqdIzOketpqozdrO7EtC0cmq76J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427600; c=relaxed/simple;
	bh=rBSTBufGzyJ1Own2gQXv1tIZWtlhUIK7ay0v2AtcpkM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=iaoo6j8DTkq3uquNzSKqKtwbXiDmx36Y0wX2z+4Q8S2P9XW0cTjEWMb53E2SftRHvGJ/TtN1Lv4ycry8TdASPuN7BB1z0Gc1Y8GItcfgt7Ftc5oTPkX1wTSsnTH/yStX+Dm9YUBQUIFi1RicfXaePytpwky/4Fg/05IN9kwRce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=IvZfPHBL; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="IvZfPHBL"
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 43I80wso029724
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 18 Apr 2024 10:00:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1713427260; bh=HJgcNoWPtra2YGumpXn8VSvSJ0doWvMxwE1qkGb9hdo=;
	h=Date:From:To:Cc:Subject;
	b=IvZfPHBL/OomM+yixhKJPuVJOGOykSpLq4hRWq8VksGfJyQUWZpqc10i5lmEygiAi
	 hB2UEiHpqvIsXBc8+ccFoUxLrpDEtkUmrZ5m4kNZm6mrIjoM3DLa1oqxS1t5bKsGqQ
	 GOZdV/xOo22v9oFgdPscwAq/zyW95qlcTPB37CR8=
Message-ID: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
Date: Thu, 18 Apr 2024 01:00:56 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: umount -r broken due to "mountinfo unnecessary"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Karel,

I noticed that "umount -r" does not work on my system for filesystems other than root:

# umount -r /usr
umount: /usr: target is busy.

Yes, umount first tries the umount2 syscall, so "target is busy" is very expected, but there is no follow-up attempt to remount fs as read-only:

umount2("/usr", 0)                      = -1 EBUSY (Device or resource busy)
openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=2998, ...}, AT_EMPTY_PATH) = 0
read(3, "# Locale name alias data base.\n#"..., 4096) = 2998
read(3, "", 4096)                       = 0
close(3)                                = 0
openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "umount: ", 8umount: )                 = 8
write(2, "/usr: target is busy.", 21/usr: target is busy.)   = 21
write(2, "\n", 1
)                       = 1
dup(1)                                  = 3
close(3)                                = 0
dup(2)                                  = 3
close(3)                                = 0
exit_group(32)                          = ?
+++ exited with 32 +++

Looking at the code, "try remount read-only" section in do_umount() from libmount/src/context_umount.c seems to only be called if all these conditions are met:
 - rc < 0
 - cxt->syscall_status == -EBUSY
 - mnt_context_is_rdonly_umount(cxt)
 - src is not NULL

I added some debug code to do_umount() to see why it fails:
        DBG(CXT, ul_debugobj(cxt, "rc=%d, cxt->syscall_status=%d, mnt_context_is_rdonly_umount=%d, src=%s",
        rc, cxt->syscall_status, mnt_context_is_rdonly_umount(cxt), src));

Result:
17555: libmount:      CXT: [0x5638caf185b0]: rc=-1, cxt->syscall_status=-16, mnt_context_is_rdonly_umount=1, src=(null)

With this, I noticed the additional hint in the log coming from lookup_umount_fs_by_statfs():

17555: libmount:      CXT: [0x5638caf185b0]: umount: lookup FS
17555: libmount:      CXT: [0x5638caf185b0]:  lookup by statfs
17555: libmount:      CXT: [0x5638caf185b0]:   trying fstatfs()
17555: libmount:      CXT: [0x5638caf185b0]:   umount: disabling mountinfo

Adding "DBG(CXT, mnt_fs_print_debug(cxt->fs, stderr));" in do_umount() confirmed my assumptions:

19114: libmount:      CXT: ------ fs:
source: (null)
target: /usr
fstype: ext4

The problem seems to be that lookup_umount_fs() first calls lookup_umount_fs_by_statfs() and when it succeeds, we only get partial information - without the source.

Commenting the following section in lookup_umount_fs():

//      rc = lookup_umount_fs_by_statfs(cxt, tgt);
//      if (rc <= 0)
//              goto done;

... allows this to work and /usr gets re-mounted ro:

23821: libmount:   UPDATE: ------ fs:
source: /dev/mapper/VG0-usr
target: /usr
fstype: ext3
optstr: rw,defaults,data=journal,nodev,remount
VFS-optstr: rw,nodev,remount
FS-opstr: data=journal
user-optstr: defaults

umount2("/usr", 0)                      = -1 EBUSY (Device or resource busy)
mount("/dev/mapper/VG0-usr", "/usr", NULL, MS_RDONLY|MS_REMOUNT, NULL) = 0

Clearly this is not the right fix, but perhaps something like this would be correct:

@@ -275,6 +275,7 @@
      || mnt_context_is_lazy(cxt)
      || mnt_context_is_nocanonicalize(cxt)
      || mnt_context_is_loopdel(cxt)
+     || mnt_context_is_rdonly_umount(cxt)
      || mnt_safe_stat(tgt, &st) != 0 || !S_ISDIR(st.st_mode)
      || has_utab_entry(cxt, tgt))
       return 1; /* not found */

I wonder if we just missed the mnt_context_is_rdonly_umount case in https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=6a52473ecd877227f6f7da2b95da0b51593ffec1?

Thanks,
 Krzysztof

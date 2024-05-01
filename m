Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9291649CF
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596759; cv=none; b=LLvl/dmI01NzrW73vSZdGjncTSRpfa3oQxFvLvh5akgLoC36leVSfw9vJv5MwlG+20c3LhPF71wSW/sC8r0ZvbmkfXqcVNYPdkIbwXLgYX+5VdV1epzfkWS5s4l2+j8e7L/OInzVx8aXGS5+Bx5lwMY4brqoNDKGVdCE3dxP3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596759; c=relaxed/simple;
	bh=Sjq4MUcm1QWt7RBaXmg2+ZOkKB5zQ6/pV+9lJMPNdyg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nM3QTD9JYL1tFTAX6CRaxRYmgJkoQy2lT26NwQe2oqVXqJSyuH4hIv/7iQfmfDjLJZE/WqRi/UHSIzGqlUHXbLaiRdPPzduhPAXmJCwV79xw6Ed6RMTgG1qRew+lKdPQk/455YtWom9bd/BauaKTDJR8Y9rimgHIvUtKsz30o9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAUCmKGs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAUCmKGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714596757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FtxNhGrx8bIbLRWNdGYaBp9VqCLgzx4lQIe9vHMf88=;
	b=eAUCmKGshkJnaqT6I6vNnvq1Raav3rA3v6LfzLLjwLHs6S9yU/ab/WnKVa3npA6+2O7Yp1
	+kFOb8fLJDQLB9vH8fRzQkvVQi2nFGLFemQYySCQp0uW0pzOZxNTisPrlX+9Uu39NUd5Cs
	gfrcUHjb6ZEX5LHPMNdS3MA+1zdKmnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Xm8ntM_KOd2F1VkSSyYAYg-1; Wed, 01 May 2024 16:52:35 -0400
X-MC-Unique: Xm8ntM_KOd2F1VkSSyYAYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1215D804C61
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 20:52:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE1B540C6CC0
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 20:52:34 +0000 (UTC)
Date: Wed, 1 May 2024 22:52:32 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40.1-rc1
Message-ID: <20240501205232.2ykq3oi2nnyu2cxz@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


The util-linux release v2.40.1-rc1 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux v2.40.1 Release Notes
================================

Changes between v2.40 and v2.40.1
---------------------------------

README.licensing/flock:
   - Add MIT license mention  [Richard Purdie]
agetty:
   - Don't override TERM passed by the user  [Daan De Meyer]
all_syscalls:
   - don't hardcode AWK invocation  [Thomas Weiﬂschuh]
   - don't warn during cleanup  [Thomas Weiﬂschuh]
   - fail if any step fails  [Thomas Weiﬂschuh]
   - use sed to extract defines from headers  [Thomas Weiﬂschuh]
autotools:
   - distribute pam_lastlog2/meson.build  [Thomas Weiﬂschuh]
bcachefs:
   - Remove BCACHEFS_SB_MAX_SIZE & check  [Tony Asleson]
docs:
   - add COPYING.MIT  [Karel Zak]
   - fix GPL name typo  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
findmnt:
   - always zero-terminate SOURCES data  [Thomas Weiﬂschuh]
   - revise the code for -I and -D option  [Masatake YAMATO]
lastlog2:
   - begin descriptions of options with a lowercase letter  [Benno Schulenberg]
lib/pager:
libblkid:
   - Fix segfault when blkid.conf doesn't exist  [Karel Zak]
   - topology/ioctl  correctly handle kernel types  [Thomas Weiﬂschuh]
   - topology/ioctl  simplify ioctl handling  [Thomas Weiﬂschuh]
libmount:
   - Fix access check for utab in context  [Karel Zak]
   - fix comment typo for mnt_fs_get_comment()  [Tianjia Zhang]
   - fix umount --read-only  [Karel Zak]
libsmartcols:
   - fix column reduction  [Karel Zak]
   - reset wrap after calculation  [Karel Zak]
libuuid:
   - (man) fix function declarations  [CismonX]
losetup:
   - losetup.8 Clarify --direct-io  [Colin Walters]
lsblk:
   - simplify SOURCES code  [Karel Zak]
lsfd:
   - (man) fix license name  [Jakub Wilk]
   - add LSFD_DEBUG env var for debugging  [Masatake YAMATO]
lslocks:
   - don't abort gathering per-process information even if opening a /proc/[0-9]* fails  [Masatake YAMATO]
   - remove a unused local variable  [Masatake YAMATO]
lsns:
   - fix netns use  [Karel Zak]
   - report with warnx if a namespace related ioctl fails with ENOSYS  [Masatake YAMATO]
   - tolerate lsns_ioctl(fd, NS_GET_{PARENT,USERNS}) failing with ENOSYS  [Masatake YAMATO]
meson:
   - Add build-blkdiscard option  [Jordan Williams]
   - Add build-blkpr option  [Jordan Williams]
   - Add build-blkzone option  [Jordan Williams]
   - Add build-blockdev option  [Jordan Williams]
   - Add build-chcpu option  [Jordan Williams]
   - Add build-dmesg option  [Jordan Williams]
   - Add build-enosys option  [Jordan Williams]
   - Add build-fadvise option  [Jordan Williams]
   - Add build-fsfreeze option  [Jordan Williams]
   - Add build-ipcmk option  [Jordan Williams]
   - Add build-ldattach option  [Jordan Williams]
   - Add build-lsclocks option  [Jordan Williams]
   - Add build-lsfd option and make rt dependency optional  [Jordan Williams]
   - Add build-rtcwake option  [Jordan Williams]
   - Add build-script option  [Jordan Williams]
   - Add build-scriptlive option  [Jordan Williams]
   - Add build-setarch option  [Jordan Williams]
   - Add have_pty variable to check if pty is available  [Jordan Williams]
   - Add missing check for build-ipcrm option  [Jordan Williams]
   - Define _DARWIN_C_SOURCE on macOS as is done in Autotools  [Jordan Williams]
   - Don't define HAVE_ENVIRON_DECL when environ is unavailable  [Jordan Williams]
   - Fix build by default and install behavior for build-pipesz option  [Jordan Williams]
   - Fix false positive detection of mempcpy on macOS  [Jordan Williams]
   - Only build libmount when required  [Jordan Williams]
   - Only pick up the rt library once  [Jordan Williams]
   - Only require the crypt library when necessary  [Jordan Williams]
   - Only use the --version-script linker flag where it is supported  [Jordan Williams]
   - Remove libblkid dependency on libmount  [Jordan Williams]
   - Remove lingering mq_libs variable  [Jordan Williams]
   - Require pty for the su and runuser executables  [Jordan Williams]
   - Require the seminfo type for ipcmk, ipcrm, and ipcs  [Jordan Williams]
   - Use has_type instead of sizeof to detect cpu_set_t type  [Jordan Williams]
   - Use libblkid as a dependency  [Jordan Williams]
   - Use libmount as a dependency  [Jordan Williams]
   - respect c_args/CFLAGS when generating syscalls  [Karel Zak]
pam_lastlog2:
   - link against liblastlog  [Thomas Weiﬂschuh]
po:
   - merge changes  [Karel Zak]
po-man:
   - merge changes  [Karel Zak]
strutils.h:
   - Include strings.h header for strncasecmp function  [Jordan Williams]
tests:
   - (lsfd  mkfds-multiplexing) skip if /proc/$pid/syscall is broken  [Masatake YAMATO]
   - (lsns  ioctl_ns) add more debug print  [Masatake YAMATO]
   - (lsns  ioctl_ns) record stdout/stderr for debugging the case  [Masatake YAMATO]
   - (test_mkfds  sockdiag) verify the recieved message to detect whether the socket is usable or not  [Masatake YAMATO]
textual:
   - fix some typos and inconsistencies in usage and error messages  [Benno Schulenberg]
xalloc.h:
   - Include stdio.h header for vasprintf function  [Jordan Williams]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37251205E34
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487206; cv=none; b=RblBR8LtflAOBe14z+YKTwu+K9xUX9+wqIjXQSfxcYYyHNZ9Tq/Demgor/60J5fBc9fKqn/fKW0Rdjqn+6C2VBAiFQF9LiKiDGH/I20ZUQcaL9n82G/hOXN88NgZz3Yx+xCHO7Ji20Bf3n+o3Xi2cCeL5BMfyl8hpwYf8JDdSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487206; c=relaxed/simple;
	bh=7bCkYMjWq7Mq4Zap6Y6hyqwJLqIkJJGsxRQ+PdhsIsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cScRKqfNWYV2PZJqTyujMaeg+iFDp8yuYk/j2RdMbvOyXFwnj9OBxkp4RuXuwNv6NH1G/4pI9XvtVIWUT8uvuaKDosnxxRWVLGztvGQRsIAAJbjPYe/zvurqG/ybXA8iBSh1pbidAkWfhMjUR6KaX3tTOK8fd1nIvdHWs7egqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=eeKXV6Fs; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="eeKXV6Fs"
X-KPN-MessageId: 4230c5d1-20ef-11f0-bc2a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4230c5d1-20ef-11f0-bc2a-005056ab378f;
	Thu, 24 Apr 2025 11:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tjTESKofzUndaUV0qWWlhLo10u/ttQdjnt/FHEigBfk=;
	b=eeKXV6FsCVAh3BKlh4Ngslah3mXY/ywDRfKONzOt5J/J78HLoHl6eiVq97pPZIHZnTRVBM3epc84H
	 wlSR9yCVC6O1YJNLWo+/vaofk7X5cSmhX1aqyfzonCjH45cUBSX6SxLuNPMYr/X9WHTeJSGbyZip+Z
	 x4JQlyYAmJ/MM2IA=
X-KPN-MID: 33|18htha2Amsx4HnHWty73hEuEZkXzZ90qLsg9MbTOkaKTueKyTPQZM065UIMwofy
 pbbuNk9pWDEJKzUpKE/BQ4bTehcoLB9aKNhH+OXRI2FA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ZZ2voSXUD4EL8rKjgwC5wmhq47+zqyQ0/8Cj8t6H3Dk4+zeL+VTJO9qQS3g7Yzb
 Pl510RTBXGf9FkhSDBngSyg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 28913e2e-20ef-11f0-855b-005056ab7584;
	Thu, 24 Apr 2025 11:33:19 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Nathan Sharp <nwsharp@live.com>
Subject: [PATCH 5/7] pipesz: (man) improve the markup and some wordings
Date: Thu, 24 Apr 2025 11:32:35 +0200
Message-ID: <20250424093237.6432-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CC: Nathan Sharp <nwsharp@live.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/pipesz.1.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/pipesz.1.adoc b/misc-utils/pipesz.1.adoc
index b51de5887..6bc9e46c3 100644
--- a/misc-utils/pipesz.1.adoc
+++ b/misc-utils/pipesz.1.adoc
@@ -12,15 +12,15 @@ pipesz - set or examine pipe and FIFO buffer sizes
 
 == SYNOPSIS
 
-*pipesz* [options] [--set _size_] [--] [_command_ [argument] ...]
+*pipesz* [options] [*--set* _size_] [--] [_command_ [_argument_...]]
 
-*pipesz* [options] --get
+*pipesz* [options] *--get*
 
 == DESCRIPTION
 
 Pipes and FIFOs maintain an internal buffer used to transfer data between the read end and the write end. In some cases, the default size of this internal buffer may not be appropriate. This program provides facilities to set and examine the size of these buffers.
 
-The *--set* operation sets pipe buffer sizes. If it is specified, it must be specified with an explicit _size_. Otherwise, it is implied and the size is read from */proc/sys/fs/pipe-max-size*. The kernel may adjust _size_ as described in *fcntl*(2). To determine the actual buffer sizes set, use the *--verbose* option. If neither *--file* nor *--fd* are specified, *--set* acts on standard output.
+The *--set* operation sets pipe buffer sizes. If it is specified, it must be specified with an explicit _size_. Otherwise, it is implied and the size is read from */proc/sys/fs/pipe-max-size*. The kernel may adjust _size_ as described in *fcntl*(2). To see the actual buffer sizes that get set, use the *--verbose* option. If neither *--file* nor *--fd* are specified, *--set* acts on standard output.
 
 The *--set* operation permits an optional _command_ to execute after setting the pipe buffer sizes. This command is executed with the adjusted pipes.
 
@@ -38,13 +38,13 @@ The kernel imposes limits on the amount of pipe buffer space unprivileged proces
 Report the size of pipe buffers to standard output and exit. As a special behavior, if neither *--file* nor *--fd* are specified, standard input is examined. It is an error to specify this option in combination with *--set*.
 
 *-s*, *--set* _size_::
-Set the size of the pipe buffers, in bytes. This option may be suffixed by _K_, _M_, _G_, _KiB_, _MiB_, or _GiB_ to indicate multiples of 1024. Fractional values are supported in this case. Additional suffixes are supported but are unlikely to be useful. If this option is not specified, a default value is used, as described above. If this option is specified multiple times, a warning is emitted and only the last-specified _size_ is used. As a special behavior, if neither *--file* nor *--fd* are specified, standard output is adjusted. It is an error to specify this option in combination with *--get*.
+Set the size of the pipe buffers, in bytes. This option may be suffixed by *K*, *M*, *G*, *KiB*, *MiB*, or *GiB* to indicate multiples of 1024. Fractional values are supported in this case. Additional suffixes are supported but are unlikely to be useful. If this option is not specified, a default value is used, as described above. If this option is specified multiple times, a warning is emitted and only the last-specified _size_ is used. As a special behavior, if neither *--file* nor *--fd* are specified, standard output is adjusted. It is an error to specify this option in combination with *--get*.
 
 *-f*, *--file* _path_::
 Set the buffer size of the FIFO or pipe at _path_, relative to the current working directory. You may specify this option multiple times to affect different files, and you may do so in combination with *--fd*. Generally, this option is used with FIFOs, but it will also operate on anonymous pipes such as those found in */proc/PID/fd*. Changes to the buffer size of FIFOs are not preserved across system restarts.
 
-*-n*, *--fd* _fd_::
-Set the buffer size of the pipe or FIFO passed to *pipesz* as the specified file descriptor number. You may specify this option multiple times to affect different file descriptors, and you may do so in combination with *--file*. Shorthand options are provided for the common cases of fd 0 (stdin), fd 1 (stdout), and fd 2 (stderr). These should suffice in most cases.
+*-n*, *--fd* _number_::
+Set the buffer size of the pipe or FIFO corresponding to file descriptor _number_. You may specify this option multiple times to affect different file descriptors, and you may do so in combination with *--file*. Shorthand options are provided for the common cases of fd 0 (stdin), fd 1 (stdout), and fd 2 (stderr). These should suffice in most cases.
 
 *-i*, *--stdin*::
 Shorthand for *--fd 0*.
@@ -59,7 +59,7 @@ Shorthand for *--fd 2*.
 Exit, without executing _command_, in case of any error while manipulating a file or file descriptor. The default behavior if this is not specified is to emit a warning to standard error and continue.
 
 *-q*, *--quiet*::
-Do not diagnose non-fatal errors to standard error. This option does not affect the normal output of *--get*, *--verbose*, *--help*, or *--version*.
+Do not report non-fatal errors to standard error. This option does not affect the normal output of *--get*, *--verbose*, *--help*, or *--version*.
 
 *-v*, *--verbose*::
 If specified with *--get*, *pipesz* will emit a descriptive header above the table. Otherwise, if specified, *pipesz* will print the actual buffer sizes set by the kernel to standard error.
-- 
2.48.1


Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045E3BFE21
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072564; cv=none; b=rBUi9meVjhoG9HFP6REuXKTpiA9Koz59De3WbmAKi9+792LXQyaIDNBWr80Sqzc2ECJJzf+YUai6KUY7d1hKSRXZEoIHczYrk8G+PnCy/sAtCsR1ldwtRR1MbXiQDKAPka0nzttvlylITdcO3v8m34GG2ytnZ1IFRlpWc4FF28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072564; c=relaxed/simple;
	bh=3IH3LX/4MobpVPR23C8RGxHTjMOLVxnxbkEH3POpeZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2OUY90bEY+9rYVhnnfiSqZVuOVmKMfZk+PSiX64UBmz4PA9PsyLhXmpEHm6ryXZWhY5wgQ0vKBdaNcvevVJPNK+zeDwPOZjobXwAM8rmycYhW/j8RsWmFAlDA0v1lSrO2KXZI/BgmNxdGb1STMmjSYX17hUPIjPbwTcNNtZWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=PoNwUk9y; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="PoNwUk9y"
X-KPN-MessageId: 552539e0-1bd2-11f1-b183-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 552539e0-1bd2-11f1-b183-005056abad63;
	Mon, 09 Mar 2026 17:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=sAtrhP33CXst98wL7s5/uL29QhyFTESaqW/YnDNpsN4=;
	b=PoNwUk9y1oaFXEA371JWXgqjzgtwm0PILrY4TDlvPcfuXB+WOr5Du60C3kJGRRyFQcidcbH7yhNij
	 CVYEVOWlYl400WouuxicZBOq5D6JhQHi7uQqSX0oSaJjIi+C1tRXuRJ/qaOfHjctULVvrd27I+Xl+X
	 6uwajqOl+x9cYAOk=
X-KPN-MID: 33|G7HUlPUgYRBXH74OhA2DLnUm5510wu/6sUomyNLkKSOinaX/Dhz4gQ332RSnMc0
 HNvHGjtB/EFBxEa9ii0RtVvWJtMZ/1PfxfuDWGNlLk0M=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SIEPx4mfeSJTwZlKvJojkaSnsC7W57gdhMP/174+Ow9az0zxFf2vMzFhIB0vfJF
 fK/6sVkie96CxWVXoQ1e+Zw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5509c0e7-1bd2-11f1-a6cb-005056abf0db;
	Mon, 09 Mar 2026 17:09:21 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 2/2] copyfilerange: (man) correct the markup and improve the wordings
Date: Mon,  9 Mar 2026 17:09:03 +0100
Message-ID: <20260309160903.15490-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309160903.15490-1-bensberg@telfort.nl>
References: <20260309160903.15490-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CC: Dick Marinus <dick@mrns.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/copyfilerange.1.adoc | 61 ++++++++++++++-------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/misc-utils/copyfilerange.1.adoc b/misc-utils/copyfilerange.1.adoc
index 4d214f4db..303a1a7b2 100644
--- a/misc-utils/copyfilerange.1.adoc
+++ b/misc-utils/copyfilerange.1.adoc
@@ -4,54 +4,43 @@
 :man manual: User Commands
 :man source: util-linux {release-version}
 :page-layout: base
-:range: copyfilerange
+:command: copyfilerange
 
 == NAME
 
-copyfilerange - Copy file ranges from source to destination file.
+copyfilerange - copy range(s) from source to destination file
 
 == SYNOPSIS
 
-*copyfilerange* [options] [<source>] [<destination>] [<range>...]
+*copyfilerange* [options] _source_ _destination_ _range_...
 
 == DESCRIPTION
 
-*copyfilerange* copy file ranges from source to destination file
-*copyfilerange* is a simple utility to call the *copy_file_range*(2) system call.
+The *copyfilerange* command copies byte ranges from source to destination file.
+It is a wrapper around the *copy_file_range*(2) system call.
 
-It can be used write files with unallocated gaps (sparse files) and/or share blocks between multiple files (reflinks).
+The command can be used to create files with unallocated gaps (sparse files)
+and/or with shared blocks between multiple files (reflinks).
 
-== ARGUMENTS
+Each _range_ is of the form _source_offset_**:**_destination_offset_**:**_length_,
+with all values in bytes. If _length_ is 0, then as much data as is available is
+copied. Multiple ranges may be supplied.
 
-*source*::
-Source filename
-
-*destination*::
-Destination filename
-
-*range*::
-
-Consists of a range specified as *source_offset:dest_offset:length*
-
-All values are in bytes, if length is set to 0 copy as much as available.
-Multiple range can be supplied.
-
-When one or more of the offsets are omitted the operation will use the last used location, starting with 0
+When one or both of the offsets are omitted, the operation uses the last-used
+file location, starting with 0.
 
 == OPTIONS
 
-*-v*, *--verbose*::
-Verbose output of copied file ranges
+*-r*, *--ranges* _file_::
+Read range(s) separated by newlines from this _file_.
 
-*-r*, *--ranges*::
-Ranges filename
+*-v*, *--verbose*::
+Verbose output of the copied ranges.
 
 include::man-common/help-version.adoc[]
 
 == EXIT STATUS
 
-*copyfilerange* has the following exit status values:
-
 *0*::
 success
 *1*::
@@ -59,7 +48,7 @@ unspecified failure
 
 == NOTES
 
-The *copy_file_range*(2) system call has some serious caveats, the source and destination files must use the same filesystem type and some virtual filesystems (like procfs) won't work. *copy_file_range*(2) will use reflinks when the filesystem supports this. To use reflinks the file range most often needs to align with the filesystem block size on both the source and destination file.
+The *copy_file_range*(2) system call has some serious caveats: the source and destination files must use the same filesystem type, and some virtual filesystems (like procfs) won't work. *copy_file_range*(2) will use reflinks when the filesystem supports this. To use reflinks, the file range most often needs to align with the filesystem block size on both the source and destination file.
 
 == AUTHORS
 
@@ -68,21 +57,21 @@ mailto:dick@mrns.nl[Dick Marinus]
 == EXAMPLES
 
 ....
-~$ copyfilerange original-file reflink ::
+copyfilerange original-file reflink ::
 
-~$ copyfilerange original-file first-block ::4096
+copyfilerange original-file first-block ::4096
 
-~$ copyfilerange original-file even-blocks -r <(seq 0 8192 40960|awk '{print $1"::4096"}')
+copyfilerange original-file even-blocks -r <(seq 0 8192 40960|awk '{print $1"::4096"}')
 
-~$ copyfilerange original-file sparse-file 0:1M:1
+copyfilerange original-file sparse-file 0:1M:1
 
-~$ copyfilerange original-file split-first-mb ::1M
+copyfilerange original-file split-first-mb ::1M
 
-~$ copyfilerange original-file split-remainder 1M::
+copyfilerange original-file split-remainder 1M::
 
-~$ copyfilerange split-first-mb join ::
+copyfilerange split-first-mb join ::
 
-~$ copyfilerange split-remainder join 1M::
+copyfilerange split-remainder join 1M::
 ....
 
 == SEE ALSO
-- 
2.53.0


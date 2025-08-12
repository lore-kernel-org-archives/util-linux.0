Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0810E0
	for <util-linux@vger.kernel.org>; Tue, 12 Aug 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004154; cv=none; b=A2KVxI96BBJoRLm9kCKPs8ZMgAqco31I7gxCFMCBZt6964GVItzYM5r9NIyUUquogPO2fpdPj353djalSxcWA62/6hM9YyhFKPXdDuhW8MztNdiKBVTwDED8W892lnp6rm+SJkXButNZ68lq5RyjlP8Wjji+sPlfxdbdHxkjPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004154; c=relaxed/simple;
	bh=+I0gzS5asfROs7sLphIQ1p5QSwJdvmXITPwuFMyb5Eo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MepbfnmRAMQD9mkrIyXEJctRthQCS5vsNeBIEIHhaHp/uLIsQAYjjz1bkHqhAgh/Xt9R419643Fh8SVbJUosT6EfBegN9eWxLEf+lua04CEJ9TVqe29Go7Or2v0qHPUiK6+AG9lo9GUdHRAMsVqiqBJW0dD8NlTDUF9fFLC3Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqP2Z9rl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqP2Z9rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755004151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=8dhD+DsK5MGZy8X2gxR+6+e5N/dSWP5ar1Ce52/R3ZI=;
	b=iqP2Z9rleVSvafKdMfXz/ldlgjBW4rNnCur/LV8HEK+OTRl8uB3UkhI4FgcVknNkscqSaL
	gk0/nSJHJLRnEK4qwNhK51UTZrKzTTBom3jGuLk1HZc96pPtehU55PimyfNthgVtfPnKb7
	j7mGNr6u8DCr9qMkpCQ74rnchDl20mo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-PEoElefnNce4dEhPbnVdZw-1; Tue,
 12 Aug 2025 09:09:10 -0400
X-MC-Unique: PEoElefnNce4dEhPbnVdZw-1
X-Mimecast-MFC-AGG-ID: PEoElefnNce4dEhPbnVdZw_1755004149
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C0FA19560B1
	for <util-linux@vger.kernel.org>; Tue, 12 Aug 2025 13:09:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.95])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBC6B19560AB
	for <util-linux@vger.kernel.org>; Tue, 12 Aug 2025 13:09:08 +0000 (UTC)
Date: Tue, 12 Aug 2025 15:09:05 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] swapon: (man page) add details about fstab configuration
Message-ID: <2k6jk47pv3rgp4djrfhs6tdddhfmbjoz2jmofzf6owxnpfuvq2@bkt6bw6bldj5>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The fstab(5) man page already describes some basic aspects of "swap,"
but it makes sense to be more specific in the swapon man page and
describe everything in one place, serving as a normative reference for
what is expected on Linux in fstab for swap.

Fixes: https://github.com/util-linux/util-linux/issues/3667
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/fstab.5.adoc  |  2 ++
 sys-utils/swapon.8.adoc | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/sys-utils/fstab.5.adoc b/sys-utils/fstab.5.adoc
index f5b4d0dcb..53d7dced5 100644
--- a/sys-utils/fstab.5.adoc
+++ b/sys-utils/fstab.5.adoc
@@ -56,6 +56,8 @@ The file *fstab* contains descriptive information about the filesystems the syst
 
 The file is not read by *mount*(8) only but often is used by many other tools and daemons, and proper functionality may require additional steps. For example, on systemd-based systems, it's recommended to use *systemctl daemon-reload* after *fstab* modification.
 
+See the *swapon*(8) man page for details about swap area fstab configuration.
+
 Each filesystem is described on a separate line, with fields separated by tabs or spaces. The line is split into fields before being parsed. This means that any spaces or tabs within the fields must be escaped using \040 or \011, even within quoted strings (e.g. LABEL="foo\040bar").
 
 Lines starting with '#' are comments. Blank lines are ignored.
diff --git a/sys-utils/swapon.8.adoc b/sys-utils/swapon.8.adoc
index a25309d18..f4516c66a 100644
--- a/sys-utils/swapon.8.adoc
+++ b/sys-utils/swapon.8.adoc
@@ -30,6 +30,7 @@ Calls to *swapon* normally occur in the system boot scripts making all swap devi
 
 *-a*, *--all*::
 All devices marked as "swap" in _/etc/fstab_ are made available, except for those with the "noauto" option. Devices that are already being used as swap are silently skipped.
+See *FSTAB CONFIGURATION* section for more details.
 
 *-T*, *--fstab* _path_::
 Specifies an alternative fstab file for compatibility with *mount*(8). If _path_ is a directory, then the files in the directory are sorted by *strverscmp*(3); files that start with "." or without an .fstab extension are ignored. The option can be specified more than once. This option is mostly designed for initramfs or chroot scripts where additional configuration is specified beyond standard system configuration.
@@ -91,6 +92,52 @@ Be verbose.
 
 include::man-common/help-version.adoc[]
 
+== FSTAB CONFIGURATION
+
+The command *swapon --all* reads configuration from _/etc/fstab_ (or from a file specified by the *--fstab* command line option). Only fstab entries with the filesystem type (3rd field) set to "swap" are relevant.
+
+The option *--options* accepts values in the same form as can be specified in the fourth field in fstab.
+
+=== The first field (source)
+
+Specify the swap source. If the source is a regular file, it is addressed by an absolute path.
+
+If the swap is a block device, it can be addressed by device path, swap area tags *LABEL=* or *UUID=* (see *mkswap*(8) for more details), or by partition tags like *PARTLABEL=* or *PARTUUID=*.
+
+=== The second field (target)
+
+Unused by *swapon*, the recommended convention is to use "none".
+
+=== The third field (type)
+
+Requires "swap" as the filesystem type.
+
+=== The fourth field (options)
+
+It is formatted as a comma-separated list of options. All unknown options are silently ignored. If options are unnecessary, the recommended convention is to use "default". The options specified in fstab extend or overwrite settings specified on the swapon command line.
+
+Supported swap options:
+
+*noauto*::
+Ignore entry when *swapon --all* is given.
+
+*nofail*::
+Do not report errors for this device if it does not exist.
+
+*discard*[**=**_policy_]::
+Enable swap discard. The supported settings are *discard*, *discard=once*, or *discard=pages*. For more details, see the **--discard** command line option.
+
+**pri=**_priority_::
+Specify the priority of the swap device. For more details, see the **--priority** command line option.
+
+=== The fifth field
+
+Unused by *swapon*, the recommended convention is to keep it empty.
+
+=== The sixth field
+
+Unused by *swapon*, the recommended convention is to keep it empty.
+
 == EXIT STATUS
 
 *swapoff* has the following exit status values since v2.36:
-- 
2.50.1


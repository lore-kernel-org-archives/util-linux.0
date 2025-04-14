Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF1F9FE
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623974; cv=none; b=L7CtMfITZFZaQj0hJdQ+CfF5XFx0mxbPnQ0P8gMp2NunKXVmBdNv9dKvD018XOh7fmaAu8E9yo/KcnoBbxjei/rWCz1HYLTGr8/APO0rYBSFJdL6+5aSdc93S1Nph2qcPekfVQrsDcXtDKmgWbB5HDQyFGX1ttPze+31hrKNnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623974; c=relaxed/simple;
	bh=e2dgEnTTYxmly9kRupTbNXo6hneUmMndmVxaZegmNv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uas26c7o2ogZWXduJ7ty54hlCZDjcoyvmDyP8fG3bZzF6/8cLK/AeZlwG6xKTs4s3ONOF8m8MjWeRVBicWtVLkvOrLdCV3twYFguyhCpmmBBRCfMxz17zD3Gu0nDNRsotKfUe2/SZdlD5kVafkiodOZP6836wLy44MVwFYNHHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=IlatEKLY; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="IlatEKLY"
X-KPN-MessageId: 53615881-1915-11f0-a82e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 53615881-1915-11f0-a82e-005056abad63;
	Mon, 14 Apr 2025 11:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=PcPjN0oGSadX7sAPz0wRaUvjRxEAwmcyiQ5dxBjWHK0=;
	b=IlatEKLYS7FefsGBjy7jIqEWNXAm5vsir+AtIk+s0wrzGAzJkvP3jFxaAWvptaTh4AkD8EdoBeKD1
	 4y9z2w+zPwZ3DV9eo2ooVjMl5P3C5Ul6cvLR5FGNXH5SS0vA2kI11QFWkmpeip3VNBz1Ict3ex1HBp
	 VO7p42yeED2hPXr8=
X-KPN-MID: 33|V4IUc8LK9Rd9CK8M8g4g6Mamy+oRI5m02v/8eRq2qpoRCOnVlJGAmfPv7nNC56E
 eR7UF8haK1lCiOB/yMgwDfbI6KmJR8U3WqFvxcShOSVA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|51cuzcXAK34T7ogYNdwG4/zigVGvlg+kJuGo7Mj+dXgwMa2gR/++GQ4mp93rs/i
 diDDaDYEnkwB+SZP/TLx2uA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 47236139-1915-11f0-959e-005056abf0db;
	Mon, 14 Apr 2025 11:46:02 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] docs: fix a few indentation issues
Date: Mon, 14 Apr 2025 11:45:29 +0200
Message-ID: <20250414094534.9504-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That is: add "+" or " +" to keep paragraphs together.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/cal.1.adoc    | 1 +
 sys-utils/flock.1.adoc   | 2 +-
 sys-utils/hwclock.8.adoc | 6 ++++--
 sys-utils/setpriv.1.adoc | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.1.adoc b/misc-utils/cal.1.adoc
index 06b4238df..9f1740620 100644
--- a/misc-utils/cal.1.adoc
+++ b/misc-utils/cal.1.adoc
@@ -102,6 +102,7 @@ This option sets the adoption date of the Gregorian calendar reform. Calendar da
 * _gregorian_ - display Gregorian calendars exclusively. This special placeholder sets the reform date below the smallest year that *cal* can use; meaning all calendar output uses the Gregorian calendar system. This is called the proleptic Gregorian calendar, because dates prior to the calendar system's creation use extrapolated values.
 * _iso_ - alias of _gregorian_. The ISO 8601 standard for the representation of dates and times in information interchange requires using the proleptic Gregorian calendar.
 * _julian_ - display Julian calendars exclusively. This special placeholder sets the reform date above the largest year that *cal* can use; meaning all calendar output uses the Julian calendar system.
+
 +
 See *DESCRIPTION* above.
 
diff --git a/sys-utils/flock.1.adoc b/sys-utils/flock.1.adoc
index 08843942f..247ab385f 100644
--- a/sys-utils/flock.1.adoc
+++ b/sys-utils/flock.1.adoc
@@ -82,7 +82,7 @@ Fail if the lock cannot be acquired within _seconds_. Decimal fractional values
 
 *--fcntl*::
 Instead of flock(2), apply an fcntl(2) open file description lock (that is, using the F_OFD_SETLK (non-blocking) or F_OFD_SETLKW (blocking) commands). These locks are independent of those applied via flock(2), but, unlike traditional POSIX fcntl() locks (F_SETLK, F_SETLKW), have semantics matching those of flock(2).
-
++
 This is only available on kernel versions >= 3.15.
 
 *--start* _offset_::
diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index 350d50275..e30fb5e90 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -91,11 +91,12 @@ Set the Hardware Clock to the time given by the *--date* option, and update the
 This is an alternate to the *--hctosys* function that does not read the Hardware Clock nor set the System Clock; consequently there is not any drift correction. It is intended to be used in a startup script on systems with kernels above version 2.6 where you know the System Clock has been set from the Hardware Clock by the kernel during boot.
 +
 It does the following things that are detailed above in the *--hctosys* function:
-
++
 * Corrects the System Clock timescale to UTC as needed. Only instead of accomplishing this by setting the System Clock, *hwclock* simply informs the kernel and it handles the change.
 * Sets the kernel's NTP '11 minute mode' timescale.
 * Sets the kernel's timezone.
 
++
 The first two are only available on the first call of *settimeofday*(2) after boot. Consequently this option only makes sense when used in a startup script. If the Hardware Clocks timescale configuration is changed then a reboot would be required to inform the kernel.
 
 *-w*, *--systohc*::
@@ -166,8 +167,9 @@ This option was added in v2.26, because it is typical for systems to call *hwclo
 * (Re)calculating drift factor on every shutdown delivers suboptimal results. For example, if ephemeral conditions cause the machine to be abnormally hot the drift factor calculation would be out of range.
 * Significantly increased system shutdown times (as of v2.31 when not using *--update-drift* the RTC is not read).
 
++
 Having *hwclock* calculate the drift factor is a good starting point, but for optimal results it will likely need to be adjusted by directly editing the _{ADJTIME_PATH}_ file. For most configurations once a machine's optimal drift factor is crafted it should not need to be changed. Therefore, the old behavior to automatically (re)calculate drift was changed and now requires this option to be used. See the discussion below, under *The Adjust Function*.
-
+ +
 This option requires reading the Hardware Clock before setting it. If it cannot be read, then this option will cause the set functions to fail. This can happen, for example, if the Hardware Clock is corrupted by a power failure. In that case, the clock must first be set without this option. Despite it not working, the resulting drift correction factor would be invalid anyway.
 
 *-v*, *--verbose*::
diff --git a/sys-utils/setpriv.1.adoc b/sys-utils/setpriv.1.adoc
index 79c1ec2d0..66a087b87 100644
--- a/sys-utils/setpriv.1.adoc
+++ b/sys-utils/setpriv.1.adoc
@@ -44,6 +44,7 @@ Note the following restrictions (detailed in *capabilities*(7)) regarding modifi
 * A capability can be added to the ambient set only if it is currently present in both the permitted and inheritable sets.
 * Notwithstanding the syntax offered by *setpriv*, the kernel does not permit capabilities to be added to the bounding set.
 
++
 If you drop a capability from the bounding set without also dropping it from the inheritable set, you are likely to become confused. Do not do that.
 
 *--keep-groups*::
-- 
2.48.1


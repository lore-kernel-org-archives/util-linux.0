Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD5189B8C
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883400; cv=none; b=MdMOLrTxqPOsPjhnaq+NvLq8LycjYdfflvuA6ndZuvv/Q87VTgEFOxvkkeso2dR44iQBetNSolZIKEvaD0ZnhxD2TEeQzKdMDnb+blzl5YX4kU8BSyD06ckP3d1Fe3appvTRe2IvKhCHllx0dP7Vi5hOH0msHVkpVxII9KoYUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883400; c=relaxed/simple;
	bh=dnur3zVdnFpcHn8E01jTmdnQsOx01Ehof5nqoi1SsgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbY0a6CFku0eieLHQHDKJHTSs0pwfuV91q8KmmY92Xlshjl0ILOpf1RomPG7hy99Z2UXQhR/hjCEkKMv0883/v1xV91It98gBtUKqnV/QKqQviuRlvg/0xDqwX/xsOedzGdsft9NwxUkgW59L9fB/Ao4E4+HkqDn+yWUbY5ryFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=hpejehcS; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="hpejehcS"
X-KPN-MessageId: 49370518-1b71-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 49370518-1b71-11f0-8ec8-005056994fde;
	Thu, 17 Apr 2025 11:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ppAbrIlOGDiGCmiVV6rUkmBq1hkTEnlCImSDRRVR8oM=;
	b=hpejehcSIe85uxIzxlqkPRdBgINBofFxZUzwr1AM5tzHckggBSrjml0GGfdUboJeMNhpq2/H9XrBH
	 FoJh40PFmVL8CL3WTdIWUC9AGDlzl5qKrCY+F0N3iRsGeJt6WlAU8O82yLFMk2yFHTbUzjjN3YGs16
	 zq9u5Tyv+PSeW86A=
X-KPN-MID: 33|SjegCnEY3KQDpybKlAxbUTbpQX/GKy4cj9Sf68AiOmiInpprlTHf/TNl2aUVhY6
 TnHZJfBU5ajA3900Huasu+w==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BMdr74fKsziqKcmIf28C/1l/5Wxr1hPFIytgA3AC73gWpbR9/+f9/fkxmbrl/rT
 7rMwTTuPy453Hlou68qiNBg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 29e9855c-1b71-11f0-9da2-00505699b758;
	Thu, 17 Apr 2025 11:48:49 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/10] rtcwake: (man) reduce an inflated table to sane proportions
Date: Thu, 17 Apr 2025 11:48:18 +0200
Message-ID: <20250417094825.20870-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asciidoctor puts an unneeded blank line into every table cell (this
is fixed in git [1], but not released yet), and will unnecessarily
wrap text in a cell when the text is slightly longer than average.

Replace the table with a block of preformatted text, and replace
the "+5min" example with a true format that covers most cases,
and give some examples of that format after the block.

[1] https://github.com/asciidoctor/asciidoctor/commit/9cb73f8c9bee

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/rtcwake.8.adoc | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sys-utils/rtcwake.8.adoc b/sys-utils/rtcwake.8.adoc
index 481a586c5..b118534c8 100644
--- a/sys-utils/rtcwake.8.adoc
+++ b/sys-utils/rtcwake.8.adoc
@@ -37,19 +37,22 @@ Specify an alternative path to the adjust file.
 Read the clock mode (whether the hardware clock is set to UTC or local time) from the _adjtime_ file, where *hwclock*(8) stores that information. This is the default.
 
 *--date* _timestamp_::
-Set the wakeup time to the value of the timestamp. Format of the timestamp can be any of the following:
-
-[cols=",",]
-|===
-|YYYYMMDDhhmmss |
-|YYYY-MM-DD hh:mm:ss |
-|YYYY-MM-DD hh:mm |(seconds will be set to 00)
-|YYYY-MM-DD |(time will be set to 00:00:00)
-|hh:mm:ss |(date will be set to today)
-|hh:mm |(date will be set to today, seconds to 00)
-|tomorrow |(time is set to 00:00:00)
-|+5min |
-|===
+Set the wakeup time to the value of this timestamp.
+The format of _timestamp_ can be any of the following:
++
+....
+ YYYYMMDDhhmmss
+ "YYYY-MM-DD hh:mm:ss"
+ "YYYY-MM-DD hh:mm"      (seconds is 00)
+ YYYY-MM-DD              (time is 00:00:00)
+ hh:mm:ss                (date is today)
+ hh:mm                   (date is today, seconds is 00)
+ +number[smhd]           (seconds/minutes/hours/days after now)
+ tomorrow                (time is 00:00:00)
+....
++
+Examples of the **+**_number_[*smhd*] format are: *+5m*, *+6h*, *+2d*.
+The unit specifier may be longer: *+5min*, *+6hours*, *+2days*.
 
 *-d*, *--device* _device_::
 Use the specified _device_ instead of *rtc0* as realtime clock. This option is only relevant if your system has more than one RTC. You may specify *rtc1*, *rtc2*, ... here.
-- 
2.48.1


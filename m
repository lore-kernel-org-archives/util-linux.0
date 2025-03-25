Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A417433A8
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899448; cv=none; b=bNxP3jeWQwH8li2HKFxxKMG8qlYCg+nGxNsaBI0oxEJKLxZz57WmCop45XCwTSi8efmTzHQnYMa2x1CSt+5t+7DEti7fkBxfVx+DN8XTzoZmk8K0ofuvENQWptOAtMog7fWT3GDKhI68J//j9eiiejQzFthe2lNjsUti/DkmXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899448; c=relaxed/simple;
	bh=TxYz07Fc4b3vgSqcdNUKEstVB0uX0EP7mTVuj2zJPcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAKYhuzFroTS4EF4HZUz44lvxAPJdtkNV7A4k7i3cwVqEs17C3VYQuuuigfgYdVk5SDjZ+0rvWrEI0f6KBLPh8fQUD/CgpcpWzlB2mUJ8VrG282R+59fv0xiFzIrWPegruibvp6LYPGOFrPcGSAdIGIHpIzp7+SFMWYVLnSNebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Kg6hlZIO; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Kg6hlZIO"
X-KPN-MessageId: 21ea4818-0966-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 21ea4818-0966-11f0-86cb-005056aba152;
	Tue, 25 Mar 2025 11:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oRMXGGN+GmhdSi4w9FMCMKlqyHrx5HD+5OTmf8HTz6w=;
	b=Kg6hlZIOKTFsjMgzCdCLg+72xrlZvBmmfHmADZ4u//PFrMeqU1xm/YOLms6JcrnNcxI8QBRmLG3vi
	 BaZ5fwnUUzXpxNFwlU4wGCWiKmXsvnuolDd2s518Obd1iDDeEBoA7ZnC0hf7bHl7JpfKWWwWCOZSCO
	 XXK8vNHH5v5VUN+Y=
X-KPN-MID: 33|0f8nSHlU6ubn+/nu0zqNQxP/w1HGDs4l+yxIaqYjpPta/DjePT6X3tQyoJQ7rOs
 OkEZ6wwhORVpxmSfx3YDAxVlXxzHCZkHaVDAY3eIe6s4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6O15SswZ/MCSaVFJx5ZUWRFl/Sr0u8EXHqPf5TVk17mVVKugJGMIgN29i4KVWdy
 z6YlVmKJ/qCFHgJygg3luIg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 12643ae1-0966-11f0-9b42-005056ab1411;
	Tue, 25 Mar 2025 11:44:05 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/11] swapon: improve a translator hint, and remove a pointless one
Date: Tue, 25 Mar 2025 11:43:01 +0100
Message-ID: <20250325104305.23980-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference to "each entry below" made no sense, as that second
translator hint is not before a gettextized message and therefore
did not make it into the POT file.  Gettextizing that message is
not useful as 1) there is nothing to translate, and 2) allowing
the translators to fiddle with the tabs is too complicated, and
3) the --summary output is deprecated anyway.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/swapon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 15efa481a..83ec702d5 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -260,7 +260,8 @@ static int display_summary(void)
 	if (!itr)
 		err(EXIT_FAILURE, _("failed to initialize libmount iterator"));
 
-	/* TRANSLATORS: The tabs make each field a multiple of 8 characters. Keep aligned with each entry below. */
+	/* TRANSLATORS: The tabs make each field a multiple of 8 characters.
+	 * Please keep the translation aligned with the original. */
 	printf(_("Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n"));
 
 	while (mnt_table_next_fs(st, itr, &fs) == 0) {
@@ -271,7 +272,6 @@ static int display_summary(void)
 		off_t size = mnt_fs_get_size(fs);
 		off_t used = mnt_fs_get_usedsize(fs);
 
-		/* TRANSLATORS: Keep each field a multiple of 8 characters and aligned with the header above. */
 		printf("%s%*s%s%s\t%jd%s\t%jd%s\t%d\n",
 			src,
 			srclen < 40 ? 40 - srclen : 1, " ",
-- 
2.48.1


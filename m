Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1363D3B8
	for <util-linux@vger.kernel.org>; Sun,  2 Feb 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738512408; cv=none; b=U18os2irStjpNo0Qn9KfQzdUqg9NSEnoObWCEQKte2NU25yOKVsYw0pFtHcTO9No0HYwGEZ1EMjzOaE7/fv9va6PZHpYldZ0pZv3xMeOZmAjmf5kczYdjYNFSIv5E2L56LtE6C2aBhXrz7Fu5sCYZ3ur8tadJpd2luto9PAFMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738512408; c=relaxed/simple;
	bh=u+cZzD4+3VCreCBJTpocUBesQ6yGAlzXFnoPWeBoNeQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hdSo2TYAjkpIO33dyThcF29MdDBVABK92IZ0YdHbU2ivmoYBeilDhKapoutD/Pao701GypyMKoSa5GvcK9KMd/N4ZtSQefci4MBz28e5GiCENzYyZshWdfS8zMSOVLAtYCfSIT0Q4k9LEYjV1TwHWJX0rmlynH0CFYd4Wxu9+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=hBFdwYJe; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="hBFdwYJe"
X-KPN-MessageId: dd49de50-e17f-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dd49de50-e17f-11ef-8d8a-005056aba152;
	Sun, 02 Feb 2025 17:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=AnQePF1LThr+c04n5VNwDdea2OuGdELakAAQApPv/7s=;
	b=hBFdwYJexHPFiSjpRF52jqeuw1TrQgoo+NpvmLaIMCZySHcLjr61AB6tNgq88EP0+Q7z6f6Y6/Wfr
	 sGtuXnAhwXCxUysjMOc4hMKiOol2MV400hjO1ME4kbnCmciYW2So1IgieAGSovkbLr+c+OYo5KZqBG
	 haXIpnb43P6z7rKk=
X-KPN-MID: 33|vn/qClNy+B+JiIumqMKPY/k2NttnjCiwH39YuIYQ6m2fZc2TVqjCnvfYgnoZd/x
 NaHN6xG7kI2KuSuWc06sJ8PwZN9ymV+O8faA15WbIjDo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5oFQri9e+QrS8chOfrRH1Lbzf8Fubuf/ZULd421LY4k0IRQjKsPVwnqRVcuvXO/
 5L1mwonvEEk0xynUEzJT05Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id aea3ad07-e17f-11ef-a315-005056abf0db;
	Sun, 02 Feb 2025 17:06:38 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] setpriv: consistently use "<caps>" to indicate a list of capabilities
Date: Sun,  2 Feb 2025 17:06:23 +0100
Message-ID: <20250202160623.15408-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing "<caps,...>" did not indicate that each capability name
must be preceded by "+" or "-".  Also, to indicate that the list needs
to be separated by commas, one would have to use "<cap>[,...]", not
"<cap,...>".  So... instead of trying to cram all that info in there,
just say "<caps>", like for --bounding-set.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/setpriv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 907845545..f68e6c48a 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -134,8 +134,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d, --dump                  show current state (and do not exec)\n"), out);
 	fputs(_(" --nnp, --no-new-privs       disallow granting new privileges\n"), out);
-	fputs(_(" --ambient-caps <caps,...>   set ambient capabilities\n"), out);
-	fputs(_(" --inh-caps <caps,...>       set inheritable capabilities\n"), out);
+	fputs(_(" --ambient-caps <caps>       set ambient capabilities\n"), out);
+	fputs(_(" --inh-caps <caps>           set inheritable capabilities\n"), out);
 	fputs(_(" --bounding-set <caps>       set capability bounding set\n"), out);
 	fputs(_(" --ruid <uid|user>           set real uid\n"), out);
 	fputs(_(" --euid <uid|user>           set effective uid\n"), out);
-- 
2.48.1


Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2E1DC98B
	for <util-linux@vger.kernel.org>; Thu,  3 Jul 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554103; cv=none; b=ll0r2EHtsgtKZ1Qojr+6mqLB0NhRNnvQNjdoiSuq+Ec8AJTkoI+u97M24hn2P56JJjaDvoIJuDps7LY8RxsppeHa2WcV5OqK9Jee3ehbYkhGQh6SHRN8TqncGrm0MoCq/CIbo7PPyNWY6thAQVWEeUxBOhnNSqsjo5JO680ld7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554103; c=relaxed/simple;
	bh=+q3udQYjgCzIzM6N/YKrdSHl2XQ6nt+JvRYoFjiCB/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgfCtpTeLf5/BsBEzkUOQk/emFEBhURoizfUu0wj4nmyrSkdX9PNegMomLQS//G9lhLBaqkYZWsDkoxd52TimUoCdvDIalQhXItbjzkdBMue4tZyqqSKTmsmFPBLdxH5mJVG3gf8qFwh33IfTJ0PVMQhzCDqwV/TmHNf6uo1exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=pEsxQyXh; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="pEsxQyXh"
X-KPN-MessageId: d9e21ba6-581c-11f0-a833-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d9e21ba6-581c-11f0-a833-005056abad63;
	Thu, 03 Jul 2025 16:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=dRtVca1mUK4bcd6Olx1cfxZfbztssTe3hWrhaEz6kOo=;
	b=pEsxQyXhY/iG3LZ32riYVrwvy+LNIjJaaVdnwEu51OWJKcm4fiuRjW9ZvIPgz3gOkWS43hsXFaEIU
	 Ma7OWa5RaIhVm8AdkycSbB0ZDrFtr0AgYJwjF4a6MZ0HstPCIscPOih3LxyVcMTfb+/LNmH52Rbz6Z
	 VtXHHjgiWKKrUdWU=
X-KPN-MID: 33|Hehi1yfUEUWp/rC7UDHaCxEAZuaI2xQsLLqWdlZRGSlnp6Aluiz0i+PanRR7MZv
 Uj9RMEDl8nrtETXEksu8zWPEjCnOOc1wXmcYnrjCZgng=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|b6kgBI6j9No73BLAVHNMv2zNDWX06OyvRkpeoyN21rcTQVcKt3tTpkGUXoafElX
 adoAItOSSYFEqD1qFuApEZw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c20d575e-581c-11f0-95bb-005056abf0db;
	Thu, 03 Jul 2025 16:48:18 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4 V2] chrt: do not try to interpret the --pid option itself as a PID
Date: Thu,  3 Jul 2025 16:47:50 +0200
Message-ID: <20250703144752.29971-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703144752.29971-1-bensberg@telfort.nl>
References: <20250703144752.29971-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When not specifying a PID with --pid, `chrt` would report:

  chrt: invalid PID argument: '--pid'

That was silly.  After this change, `chrt --pid` will report:

  chrt: too few arguments

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 415a9aa77..a72c0de26 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -474,6 +474,8 @@ int main(int argc, char **argv)
 			policy_given = true;
 			break;
 		case 'p':
+			if (argc - optind == 0)
+				errx(EXIT_FAILURE, _("too few arguments"));
 			errno = 0;
 			/* strtopid_or_err() is not suitable here; 0 can be passed.*/
 			ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
-- 
2.48.1


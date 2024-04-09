Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1277F3E
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647612; cv=none; b=S/QDF3V/gm9qhSisZj9raXRu/+WgFG681vx8pn2K9Q1PiYLpgOaNK6tUYEDsisGA8ZzQQyq/69t8I7c6xZVnzDXQLa0ltAiR31S9+tL4gYJYOJOXnuCtKkouo4B4SJKVd8UJpDUVL9BPdYsJXTzut6dQW87cIHrwuQGyRrSTs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647612; c=relaxed/simple;
	bh=mC2DNabuXMcvC5IvBBlqcw29VkOE1FaNIa3O0jgmN2s=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=UAozkYNZZg+NoTwtcvt91y91N4uBgr38Oef3u17DxyzejAPO86johvPLVJVaW6Eh8zpicYTSEwlTMJjoGRYZioN97U1oabqYc4sa+8Rpk5UZbvDwUTGwxkM2U8LkHjO8MwD9ZovlllrJEZC3Q+1GVaNeHJu1RtwKpnasO22fXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=J46i8qr4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="J46i8qr4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/UUo7B9jS7QN3sn/a1VeqhBcCuYw9cti+c4TwcTM9MU=; t=1712647608; x=1713252408; 
	b=J46i8qr4tAYdWZAvE9lX/4znArdODvIaTcc89FRaLU+JAgdHrtSClQ8gszKvT/GclXrzmZbLJjh
	kWHCvX2thrhEM5Y4fx8EFHNMQUolEFW+GKghzhQCpeNGTrEieNGpcztiR2n/ZX1uhVxr3u6ANLvCE
	rMa/ZjhPLawdmywubHI/iD9ZkJqERYpnfS1CQDUgNp15gsUOwPiu4ReSELOoHBafXQ+gOb6YnvVWn
	ZEgKKxE3kkd2pDWLfuKbOgwmo4uaxQxAJupve+niVbwU4HjJOgFdGKtLKWC6yz6Aj1QnfkvXZ/XWh
	bFZy1coNGq/CqlwM/rgICI5uuquJF715E2DQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          for util-linux@vger.kernel.org with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ru5sO-000000031n6-2wzV; Tue, 09 Apr 2024 09:26:40 +0200
Received: from p5dc55805.dip0.t-ipconnect.de ([93.197.88.5] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          for util-linux@vger.kernel.org with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ru5sO-00000002nGf-28CA; Tue, 09 Apr 2024 09:26:40 +0200
Message-ID: <afef1b770ad80d50660bb2c53a0a8330b88d1049.camel@physik.fu-berlin.de>
Subject: logger/{errors,formats} tests fail on 32-bit PowerPC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: util-linux <util-linux@vger.kernel.org>
Date: Tue, 09 Apr 2024 09:26:39 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

the following two tests are failing on 32-bit PowerPC with 2.40:

---------------------------------------------------------------------
  2 tests of 312 FAILED

      logger/errors
      logger/formats
---------------------------------------------------------------------

The diffs seem to be related to timestamps:

diff-{{{
--- /<<PKGBUILDDIR>>/tests/expected/logger/errors-rfc5424_exceed_size.err	2=
024-01-31 10:02:15.794809649 +0000
+++ /<<PKGBUILDDIR>>/tests/output/logger/errors-rfc5424_exceed_size.err	202=
4-04-08 15:12:24.205336645 +0000
@@ -1 +1 @@
-<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424_exceed_size -=
 - [timeQuality tzKnown=3D"1" isSynced=3D"0"] abc
+<13>1 2009-02-13T23:31:30.000000+00:00 test-hostname rfc5424_exceed_size -=
 - [timeQuality tzKnown=3D"1" isSynced=3D"0"] abc
}}}-diff

Details can be found in the full build log in [1].

Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=3Dutil-linux&arch=3Dpo=
werpc&ver=3D2.40-5&stamp=3D1712589234&raw=3D0

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

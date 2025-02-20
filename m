Received: from hera.aquilenet.fr (hera.aquilenet.fr [185.233.100.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E201B87EE
	for <util-linux@vger.kernel.org>; Thu, 20 Feb 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.100.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050871; cv=none; b=pMS6Wd2OyTT7QWmMMnQXYQaBuUg45i8Vz4O25BUxhafkW2J2dyupcw5/cpPOh45Rw6xVCoR0E0tI3b0egoRCeVorGD5PhQLFye9MdOf0FRiCQwNfTeOWIr2slVtWDvZFo3Aru43caQlATWr1GW1h6GAYgizpJFRuyXeIX+hmyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050871; c=relaxed/simple;
	bh=o+MM/p7NgD/bXmd6+T0K3OiWrBKU1j8+57IngaH3pvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnYgJmPpZfIKc0O9OG5FtQK1kiDGkf7UvNvbKkMu6WIrnL+H37dsdna9j7zNonVVGGO32xpTF9E+uVSs1ipxcDtKsJIz/0fUqrwNpF3rz/Q8u9gYR5+WPM6E7t6ePOBuOE0uwc6bOFu/HRc/klGu7aQiVun2K2FI8iuqU0HANv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aquilenet.fr; spf=pass smtp.mailfrom=aquilenet.fr; arc=none smtp.client-ip=185.233.100.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aquilenet.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquilenet.fr
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id E166F60B;
	Thu, 20 Feb 2025 12:18:22 +0100 (CET)
Authentication-Results: hera.aquilenet.fr;
	none
X-Virus-Scanned: Debian amavis at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gv92FD_HuPji; Thu, 20 Feb 2025 12:18:21 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 012791B6;
	Thu, 20 Feb 2025 12:18:18 +0100 (CET)
Received: from samy by begin with local (Exim 4.98)
	(envelope-from <samuel.thibault@aquilenet.fr>)
	id 1tl4ZO-00000001hrV-1S7m;
	Thu, 20 Feb 2025 12:18:18 +0100
Date: Thu, 20 Feb 2025 12:18:18 +0100
From: Samuel Thibault <samuel.thibault@aquilenet.fr>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.41-rc1
Message-ID: <Z7cPetD5HqKnWkDT@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
	Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u+h6c3cTlJUshwNv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>
Organization: I am not organized
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: E166F60B
X-Spamd-Result: default: False [-3.83 / 15.00];
	NEURAL_HAM(-3.00)[-1.000];
	BAYES_HAM(-1.23)[89.49%];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[]
X-Spamd-Bar: ---
X-Rspamd-Action: no action


--u+h6c3cTlJUshwNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Karel Zak, le mar. 18 févr. 2025 22:08:22 +0100, a ecrit:
> The util-linux release v2.41-rc1 is now available at
>  
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.41/
>  
> Feedback and bug reports, as always, are welcomed.

Here is a patch to fix missing references to mq_open/close.

With regards,
Samuel

--u+h6c3cTlJUshwNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index ec3f27f06..35a1e2081 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -36,7 +36,7 @@ usrbin_exec_PROGRAMS += ipcmk
 MANPAGES += sys-utils/ipcmk.1
 dist_noinst_DATA += sys-utils/ipcmk.1.adoc
 ipcmk_SOURCES = sys-utils/ipcmk.c
-ipcmk_LDADD = $(LDADD) $(POSIXIPC_LIBS) libcommon.la
+ipcmk_LDADD = $(LDADD) $(POSIXIPC_LIBS) $(MQ_LIBS) libcommon.la
 endif
 
 if BUILD_IPCRM
@@ -46,7 +46,7 @@ dist_noinst_DATA += sys-utils/ipcrm.1.adoc
 ipcrm_SOURCES = sys-utils/ipcrm.c \
 		sys-utils/ipcutils.c \
 		sys-utils/ipcutils.h
-ipcrm_LDADD = $(LDADD) $(POSIXIPC_LIBS) libcommon.la
+ipcrm_LDADD = $(LDADD) $(POSIXIPC_LIBS) $(MQ_LIBS) libcommon.la
 endif
 
 if BUILD_IPCS
@@ -56,7 +56,7 @@ dist_noinst_DATA += sys-utils/ipcs.1.adoc
 ipcs_SOURCES =	sys-utils/ipcs.c \
 		sys-utils/ipcutils.c \
 		sys-utils/ipcutils.h
-ipcs_LDADD = $(LDADD) $(POSIXIPC_LIBS) libcommon.la
+ipcs_LDADD = $(LDADD) $(POSIXIPC_LIBS) $(MQ_LIBS) libcommon.la
 endif
 
 if BUILD_IRQTOP
@@ -593,4 +593,4 @@ if HAVE_LINUX_LANDLOCK_H
 setpriv_SOURCES += sys-utils/setpriv-landlock.c
 endif
 setpriv_LDADD = $(LDADD) -lcap-ng libcommon.la
-endif
\ No newline at end of file
+endif

--u+h6c3cTlJUshwNv--

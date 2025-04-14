Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB467F9FE
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624002; cv=none; b=ktvikMCn2/aG2sy+pldG8uDNdt25ZKHt1y6plyvfH/YRVxe595/kVrrPix7kk0RfJ4CaUaSbZzxBd1iCvQO9vNQx4yr2cAAu9HTvY0df86FgyMa+uuAU7l/BkRd4UL1+ZfNRbr0KfYYJwmW8W95bZ76rqTnuOc4GaxZIDZewOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624002; c=relaxed/simple;
	bh=PsVs/qpVw8eSbckoMwovX9FGRZqlJgOtPCMhRs5fF18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsxpZy+qrwyeFn/GPaqFbPxsNHgucqA6DFG3HAe6XGO9qwAuqSLldVWlJlNwhgXz35U1vX0PxwBrBqyM/8mvhmmF5NIg1uhdlnCUw0toq+3h5/MWeWHu6+8eSl6NZa3o6owBbd91KD3RCexyZsSsD8k7lbEsSsBul/vtEDM5ZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=kxx0MRs7; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="kxx0MRs7"
X-KPN-MessageId: 6e2b3764-1915-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6e2b3764-1915-11f0-86cb-005056aba152;
	Mon, 14 Apr 2025 11:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=LaQ859JPerH5nuMTUD39UTvueYxSXp0HNFhqR6B4QGY=;
	b=kxx0MRs78uyevPAgHBVu/1LS4iWQ6hyfm4jmFJc1WVdukuwPBq1xrceDcFfu4FWXWodlN+ppquUJS
	 MTrPB/6GQBx8JoJfRhNP3gBy/tJviEm1R8pU/21671E1aIh5sHK+baHvJG+05dz+2fue47eyQB3LYx
	 zfZEXWQkgp7JMdPY=
X-KPN-MID: 33|Sm2wJJPflblRzW56hqxxmRWitNLk7mic039p+RhS7z86ZNO/dvS9fSbwNUATnw8
 lrd071okbo/2p7C5Wa0y16Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ZL/f+4pLA5NJr96z/hY19uG4bgG3INRT5puQPGdXrk3jD+dCTY3Vf3bGWcr1oHi
 c/1HM5pKH/cl44F3vCCN8RA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5c23d40e-1915-11f0-853e-005056ab7584;
	Mon, 14 Apr 2025 11:46:38 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Stefan Schubert <schubi@suse.de>
Subject: [PATCH 8/8] lastlog2: besides -v, recognize also the standard -V for --version
Date: Mon, 14 Apr 2025 11:45:34 +0200
Message-ID: <20250414094534.9504-8-bensberg@telfort.nl>
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

The --help text already proclaimed that -V would work.

CC: Stefan Schubert <schubi@suse.de>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/lastlog2.8.adoc | 6 +-----
 misc-utils/lastlog2.c      | 5 +++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/misc-utils/lastlog2.8.adoc b/misc-utils/lastlog2.8.adoc
index e14e6b9cc..8a4b604ae 100644
--- a/misc-utils/lastlog2.8.adoc
+++ b/misc-utils/lastlog2.8.adoc
@@ -70,11 +70,7 @@ Print only last-login records more recent than _days_.
 *-u*, *--user* _login_::
 Print (or modify) the last-login record of the user _login_.
 
-*-h*, *--help*::
-Display help text and exit.
-
-*-v*, *--version*::
-Display version and exit.
+include::man-common/help-version.adoc[]
 
 == FILES
 
diff --git a/misc-utils/lastlog2.c b/misc-utils/lastlog2.c
index 91ba699cf..e973b5461 100644
--- a/misc-utils/lastlog2.c
+++ b/misc-utils/lastlog2.c
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 		{"set",      no_argument,       NULL, 'S'},
 		{"time",     required_argument, NULL, 't'},
 		{"user",     required_argument, NULL, 'u'},
-		{"version",  no_argument,       NULL, 'v'},
+		{"version",  no_argument,       NULL, 'V'},
 		{NULL, 0, NULL, '\0'}
 	};
 	char *error = NULL;
@@ -163,7 +163,7 @@ int main(int argc, char **argv)
 
 	int c;
 
-	while ((c = getopt_long(argc, argv, "ab:Cd:hi:r:sSt:u:v", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "ab:Cd:hi:r:sSt:u:vV", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'a': /* active; print lastlog excluding '**Never logged in**' users */
 			aflg = 1;
@@ -214,6 +214,7 @@ int main(int argc, char **argv)
 			uflg = 1;
 			user = optarg;
 			break;
+		case 'V':
 		case 'v': /* version; Print version number and exit */
 			print_version(EXIT_SUCCESS);
 			break;
-- 
2.48.1


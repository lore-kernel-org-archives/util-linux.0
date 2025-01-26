Received: from omta004.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10428155725
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737913144; cv=none; b=LMgXMSsJYqCBlmSelmqyyzH48Rtz0VGy27vkyztuyitnUnI5m4s52YbqKqAF3IrnjAXePWQpEkVGtjcsCpP82gylM4ZD6dW9Ks1rdYwQ497URVc99RIEURQSD9B4SrsANvKps2EeYAp9goK9ZJ81B4nJYpMPphPxWGipi6UkUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737913144; c=relaxed/simple;
	bh=4Z6l3caUr8vVy4mPJ4PwBS0Osqgd65dArl5B4x6W6Z0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XsJbE1tGK64tkcYLa5Vm1nMV+4bKlkxPEnqos7jPSd1Kuk4Za75S/rmiDFV6cXpwcB0sX/FVYMvyMdqe3aPWXq/f2lNVLSQi1vC2dRW6B6tr8qS2gYAD7+K064wT1/vMW8mce/Bs9SzvcMNQ8fvKcoi1MujML0yYoRh+NievMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id bzNUthmB9yLQGc6b1tjbBb; Sun, 26 Jan 2025 17:38:55 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id c6b0taqYTJhBPc6b0tlXj1; Sun, 26 Jan 2025 17:38:54 +0000
X-Authority-Analysis: v=2.4 cv=QY3Fvdbv c=1 sm=1 tr=0 ts=6796732e
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=kj9zAlcOel0A:10 a=VdSt8ZQiCzkA:10 a=M51BFTxLslgA:10
 a=zxw95Z_jlbSrlB7XLQsA:9 a=CjuIK1q_8ugA:10
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 50QHcqc8024346
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 10:38:53 -0700
Date: Sun, 26 Jan 2025 10:38:52 -0700 (MST)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix --disable-widechar compile warnings
Message-ID: <014dda0b-0d83-64b0-e0b0-366559fed323@tuyoix.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4xfJ7VbZ+dYlYCFitqoYiSxqH88FCP8ytJM8lrdu7KfGhYfGQVoC92jT1HZsnpuCBTO75w/L6Q0v4YwTHH3nMw90p4x2HRNJ6GqsymnuaDZoUJG7WgQR3z
 R67BsiCh3TgPjvDZrC6wcrzSOVY37/0RkFgvChrI+A/RkRJTcrC2a/pvxVRilMqTh4XJP6SjE6bqB5elDQBQeWq/8OWpV6qUXyw=

Fix warnings when compiling without wide char support.

Marc.

diff -NRapruz -X /etc/diff.excludes util-linux-2.40.4/lib/mbsedit.c devel-2.40.4/lib/mbsedit.c
--- util-linux-2.40.4/lib/mbsedit.c
+++ devel-2.40.4/lib/mbsedit.c
@@ -174,8 +174,8 @@ static size_t mbs_insert(char *str, wint_t c, size_t *ncells)
 	memmove(str + n, str, bytes);
 	memcpy(str, in, n);
 	str[bytes + n] = '\0';
-out:
 #ifdef HAVE_WIDECHAR
+out:
 	free(in);
 #endif
 	return n;
diff -NRapruz -X /etc/diff.excludes util-linux-2.40.4/text-utils/pg.c devel-2.40.4/text-utils/pg.c
--- util-linux-2.40.4/text-utils/pg.c
+++ devel-2.40.4/text-utils/pg.c
@@ -146,7 +146,9 @@ static long startline;			/* start line from argv[] */
 static int nextfile = 1;		/* files to advance */
 static jmp_buf jmpenv;			/* jump from signal handlers */
 static int canjump;			/* jmpenv is valid */
+#ifdef HAVE_WIDECHAR
 static wchar_t wbuf[READBUF];		/* used in several widechar routines */
+#endif

 static char *copyright;
 static const char *helpscreen = N_("\

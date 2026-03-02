Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114D25DB12
	for <util-linux@vger.kernel.org>; Mon,  2 Mar 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478571; cv=pass; b=mqYjXk7tgMHlEpD1T7aOGOMswaVuiq4dGuSUGeB4zvc2hJWWD6B2NMtLWIqdr7LMpPVzyMrMhynQh4DKEwv3i48AsbP2yNV5EoF8hTtLpnMi0Jxs/+h+42plGQHT3wh5fZlGReFnc7bAgW+6DV4F/AEWyMOOJwt5BvTkmbLzujA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478571; c=relaxed/simple;
	bh=EguLR129CKnQI3J27HIl6YW9NMXgnaTIV3A+HCYyGuM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gY3HLYXiSol7wyJ5DCVC19zO8GCgt6skc3IlRqxTV8laFkD026Ef+5vL34eL4AoIf/lBoykrfucF8frwVFGB5wAmmhNvOr8VTJTE0wJ8kKPu6d6yBY/wPARmwehSIGLyggyoAVgGyd1cjKVtr52nbmFd8ff6O2zC6wD8n5LE/ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numin.it; spf=none smtp.mailfrom=numin.it; dkim=pass (2048-bit key) header.d=numin-it.20230601.gappssmtp.com header.i=@numin-it.20230601.gappssmtp.com header.b=cKZEdOuj; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numin.it
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=numin.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=numin-it.20230601.gappssmtp.com header.i=@numin-it.20230601.gappssmtp.com header.b="cKZEdOuj"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5789136eec.1
        for <util-linux@vger.kernel.org>; Mon, 02 Mar 2026 11:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772478569; cv=none;
        d=google.com; s=arc-20240605;
        b=LBKHv3Kv5X54b5NCNK548muRQJmqIzKZOavw2YuJYxD9N3BJq1r+UywnVzidT2YcET
         7jz7ARF80C4px4dmWwksRgUwbdJ++WxrW6O+QBvPJYu2Db9b3EBQ5jqs510SYA/xtw+x
         dbyHc/j2Nzu1IH1iVHET3dgaCviKM1cd9c9Lbsbt3aueYPDJlvpcT/RTzylbUxxyll8+
         0HHrVuVam5zgjjUeZiZNk0Fs7797kRQzbeeQev1DFBDnq6PkKay2K7HXReGxDCZCkqYx
         ak8OfoaYtFqNaovy2kIeqD8Nd/QR8pLYT+2+pFiaQeBgRlMeTunj/bGOsRQZa4pUo3dT
         R4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y+IcrAYqgH2IvAbSsxQj7A3nniKVvvcK5CDKEyf02wI=;
        fh=wGiqS6fCIXmTY01ukAaQ0f8K0pJvn/8Cx9cBD0x5bgc=;
        b=UthshtbtrDs5Ca+NAQ/1z5e2vsJ/uAbJFCqAJTO/yuFYGQXWExj8rIJbxkAfDbtLPs
         pobZt3opjHG2PslQ/BIX9NzNdTpPiwMBPPIrqUzEQKgdParjrNBaN14wwSGFFjrOfRHq
         BcnPbBhR0cV/UkvDh7T5LbeduIWj4t+hOmXpmrOKIi0zojxZR1d/aGzhkVB/O74RdAq9
         Ika+z2IiF8C4bUVZRuttoFrrcodLkQXWfvfhc3Nbl5RSN9JDsNlVvq1hEP2QRViZsFR/
         HnzHsDtk1/DvmyhNeYo/4E4bka6uKwFgE+RfwHdi7vjm3fDnDSV/Ph3wH/OCk7vck6GK
         7S0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=numin-it.20230601.gappssmtp.com; s=20230601; t=1772478569; x=1773083369; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y+IcrAYqgH2IvAbSsxQj7A3nniKVvvcK5CDKEyf02wI=;
        b=cKZEdOujdqMPpdVefdVwrn+ynuy6pdvaY5LtItH+B94RD17Tu3FOL/mZcDwJX0N0W1
         CLInLI90l2nl9zSjImzXchM2P49FdDpi334JPkbOpTYhD4Z7ceWQx9Javx3PhEeidrx9
         m/VHzbfAjlpaSnEw1Em7WNWvfbyX+My59GRT8DBOEPLT2svKyWkZEskyH5T7qBPquPBi
         cA0vXZUpWYEyk4XOeShJ0O84fFfYTAHC3nRuRpHu0TIBCmwKGRrC9XVUq5GonniccZpM
         mY2Ob5XtsFRcg8zIbgDM5JMoBDoFPWj/havM5lgVNggQqcAFxVGVtjaRuMW4e1unOqmT
         BvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772478569; x=1773083369;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+IcrAYqgH2IvAbSsxQj7A3nniKVvvcK5CDKEyf02wI=;
        b=vln73bMHreGYosHnMU/3SdQecwtio9kzvbR8S12XRYH5wKpwgFSeCaOvThfGdLwgac
         Q/rlsAl3FPUYG6TlC7bzSHJER68zcULksgN50lb3YG4s1KDYFgpB1KlAyhHZJ0VtkPua
         xVVtril11jnZ4oOPEoKCRydFJEMyQXCoYO7A1mkegZv8H3zflfOPMJwbOtFN37JibpVs
         H0uE+K+qUotCMNI+RYA9OTr+MuMiOVutArYmZ0ICRvPM8JUtQr3CuPrrFt3+lgVDX/uM
         rBfy8swI6+sGCdD8ilN78xWLpd47uaswoNk596s/bShQqUYunLBm5K51WNZdoCy8jlW0
         6z3g==
X-Gm-Message-State: AOJu0YzEceGTPAhsyae/+MUh9k1OIW42BYaNftwD6OW8AACdruyM1L+r
	51Bqwze0go1sqJMXh3R65An4X62y8dCsZlFzjjXEdADE0dXtms18dZ90/FhSAn3zJFrf1X81YqU
	V7xEMvaEIXm9TKBmsawRHW6AFvk7spycVpXI4JyUmcuN8xAD3Y7ZKA6E=
X-Gm-Gg: ATEYQzwwv+fz3Ch8f9MNLorcBjipGtaOotO4A+bXpRmOlCEX2tDE9iVqunmfdE3sbwH
	Jc4kWyXc8RDnDhlBwst9wv0e+pxuJDkHGI+Lmw7JBfuPWfFDgeEckTMwBQiGf12uKpXousSbdV/
	XMYyBNepyaNMC3nzDNZnbipaLEqlpmWPeL+YRRodHDvRg7AjB4k4VVr1gumWNbTr4uzi4PQe3gr
	WWfSiSIrhdJLH0RDeq6AMY5l+r93x7GWhZeshme1R6Tojaw6Usp5arVXlL4DQcN8IIP55gxVjs6
	QJcvFoESYo+98jRFCQ==
X-Received: by 2002:a05:7300:cd90:b0:2b7:b7e7:9025 with SMTP id
 5a478bee46e88-2bde1f17447mr5244863eec.31.1772478568501; Mon, 02 Mar 2026
 11:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Morgan <me@numin.it>
Date: Mon, 2 Mar 2026 11:08:39 -0800
X-Gm-Features: AaiRm52bIYowlHkWgz7fQDJwPInMKsuhdA4cdrnJuSTRA1FvkQqSNxDxZkMUlTA
Message-ID: <CAEUYr6ZH=9akE64zf5FM3u+Sr44oSJctk2gemiadisghEFESbg@mail.gmail.com>
Subject: [PATCH] pam_lastlog2: add -lpam to Makemodule.am
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From c8e620c6bcd044786c59f822810fc973090dbfa2 Mon Sep 17 00:00:00 2001
From: Morgan Jones <me@numin.it>
Date: Mon, 2 Mar 2026 11:03:39 -0800
Subject: [PATCH] pam_lastlog2: add -lpam to Makemodule.am

If we don't add this, we don't actually link with PAM; compare the
before and after of `lib/security/pam_lastlog2.so`.

```
Dynamic section at offset 0x2ce8 contains 31 entries:
 Tag        Type                         Name/Value
0x0000000000000001 (NEEDED)             Shared library: [liblastlog2.so.2]
0x0000000000000001 (NEEDED)             Shared library: [libsqlite3.so]
0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
0x000000000000000e (SONAME)             Library soname: [pam_lastlog2.so]
```

```
Dynamic section at offset 0x2cd8 contains 32 entries:
 Tag        Type                         Name/Value
0x0000000000000001 (NEEDED)             Shared library: [libpam.so.0]
0x0000000000000001 (NEEDED)             Shared library: [liblastlog2.so.2]
0x0000000000000001 (NEEDED)             Shared library: [libsqlite3.so]
0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
0x000000000000000e (SONAME)             Library soname: [pam_lastlog2.so]
```

This causes issues like https://github.com/NixOS/nixpkgs/issues/493934
where the library has trouble linking with PAM symbols because it is not
linked.

Signed-off-by: Morgan Jones <me@numin.it>
---
pam_lastlog2/src/Makemodule.am | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pam_lastlog2/src/Makemodule.am b/pam_lastlog2/src/Makemodule.am
index 40d597c58..629930853 100644
--- a/pam_lastlog2/src/Makemodule.am
+++ b/pam_lastlog2/src/Makemodule.am
@@ -13,7 +13,7 @@ pam_lastlog2_la_CFLAGS = \

pam_lastlog2_la_LIBADD = liblastlog2.la

-pam_lastlog2_la_LDFLAGS = $(SOLIB_LDFLAGS) -module -avoid-version -shared
+pam_lastlog2_la_LDFLAGS = $(SOLIB_LDFLAGS) -lpam -module -avoid-version -shared
if HAVE_VSCRIPT
pam_lastlog2_la_LDFLAGS +=
$(VSCRIPT_LDFLAGS),$(top_srcdir)/pam_lastlog2/src/pam_lastlog2.sym
endif
--
2.50.1

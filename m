Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574616CD33
	for <util-linux@vger.kernel.org>; Sun,  7 Dec 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765079567; cv=none; b=X5VxF5twO7NBrut6l2uwoBN4N3HFfwspRIPgvsa0NGdHvUJwPC4y/P/qVwnF4ccY3HW/HWdxkV/DbU1/LiknbOTv3kPNG6V3HfDVaLr/pTqotx549RkM4Z9F/4HBTDcEcOev6BtatAdaCic5vVWe9YxwSkQusIVqcDx4W9iVtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765079567; c=relaxed/simple;
	bh=P7L+N+uXgllACiFpeM+1GCwslOCe1xCXPT9OCYxYZWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m13Q8s7lV4BCR1sc8/xElxNfeH7D5Y/aIqJ9yd9MjH709qVM5Sgh6c2/AhvusDJYc+VNf3dQOecMr4F6YRmk+Y2EZyyJw3EIR3dyMYgyu6WeeQG2/U6z53tn4CPOmwHSUOLIBrEjWA04iugseS7Gseik5U56HfqnKkCh4KY0plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMqFfV/7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMqFfV/7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437af8444cso2841967a91.2
        for <util-linux@vger.kernel.org>; Sat, 06 Dec 2025 19:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765079565; x=1765684365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onZGbEujnmv7Lrd95O4KVMK4+ZPC/m9DZY5FQ0VFLK4=;
        b=nMqFfV/74FBz+N5ebv2l6skhsGHIE5mWQjJtpjFfc3VzNKW06VMxwD5BH1FtDduOiW
         +HqQme0oNePj433KC+Z5YU1KrIjy/cFwzjA8WqYop1axP2uwql8TFTBT6Vcq746lfB1L
         b2sPeRmZwL6/iUoOjJUIBpEwCfywgTRQEprcRJSuEVVt+0NOXOZm+a4+Cf1lSL0gQW5A
         tdObIVYd96rvVbZpKw8c9dCOxXBDi299ui7nKCDQ/hxsGWX/vhNX312vOYsR+Ix9hrta
         7WohrKK6RDWN0RJsDIvJ4RXkHGfR+5R3NeQN/dcJjnQ61Du3HOydp2CU4rH3zLJ7CVtW
         tGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765079565; x=1765684365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onZGbEujnmv7Lrd95O4KVMK4+ZPC/m9DZY5FQ0VFLK4=;
        b=PrldbF6lzWr+XlSSftCFlTJarceLDfhF+mkFDIiBkrFkStMTIACyOWzD5kSwAHgPZo
         FuoZrP5C9TKQcEPcl6sJVZiZ7vF+NNQCImcj39irfBN12kDtAlODkSYgI6+zo6Qyajxc
         tSJByMvhNGyPnnbsQrCN4OD0vn76jXDZr63VTYcf5I7V+dIjepmvxVYpwMjeZfWUK50L
         VC8+FpSt51jcjYNOsS77vGIjNIH4J3AZ+1c4F+qSf9XV0QxyU9cmUBRz6B/5ZA8J8W5q
         x7X030BuNHN43VApbZVNefY3rhwr6paQ7to2WCsJSZzZ6q5mDb/GS634DmNWGHic9CW1
         sguw==
X-Forwarded-Encrypted: i=1; AJvYcCVsBzAatMa9Kj8iIzzDecKzz3rWQzsO76wmq493H0oswrQ5kuknbvHCenE0VUmWluPmS4qljR4WT1hh@vger.kernel.org
X-Gm-Message-State: AOJu0YxCONxKJCeD5TeVQhFRIh4Na40sgVnAfzyhLmwREQlbnFhiytIO
	Zhk8nnUvSrq0WpTXUW8k81QL3Lw9MqINNHUvqab1Q4bKx8d2EoBupQCUG6u9r0bxdnbBeDnv/jc
	k+O7JfEdK/PBGWQOVOfezesf06QleQGQ=
X-Gm-Gg: ASbGnct+s1rVK+Nq7nB4zqpqWqQ1ZQaV38pQiKnJwuXj8i6W00hGj5XskDjS5ufvBZ/
	DuW2rj/F5b95u0UG2W23eb4wVeZvcWGV4J29TCUavGeJByJgRcRAqk6VmHENWDSnXn0/T1khdBm
	PX0VOwcFbk9N27sIZthQrDx473d5yhl4aNkcJoD3VwbEWjNkWbW+ab3tWzXQWNvrJepr+rqGa/Z
	CzjQoIIZX10rrj33JcfjZoI5JzuTJvo/Kds9Abm+rGvsJ4Qhj8aSWL2kqxnnA1DnGloeQXg
X-Google-Smtp-Source: AGHT+IHRR9l7HPZmkDnAS+C354qm9ydXjCrOUrDKVwGGfkPfCpIDzmA64JiEJqNem/46TmeSotiRCSK/F5Dm5m1lSso=
X-Received: by 2002:a17:90a:d44d:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-349a24ea6a0mr3507128a91.6.1765079565166; Sat, 06 Dec 2025
 19:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601093150.16912-1-alx@kernel.org> <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct> <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
In-Reply-To: <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Sun, 7 Dec 2025 11:52:08 +0800
X-Gm-Features: AQt7F2o3km7lVpn3e2auuETzTjpuneODSZA1KrejV5Mneu1QrycjpZD2dHjNW9g
Message-ID: <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
Subject: [PATCH] x32: Switch back to assembly syscall wrapper for prctl
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Alejandro Colomar <alx@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Content-Type: multipart/mixed; boundary="0000000000007b8c210645549c2e"

--0000000000007b8c210645549c2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 10:06=E2=80=AFPM Adhemerval Zanella Netto
<adhemerval.zanella@linaro.org> wrote:
>
> The x32 and or1k (which also uses similar implementation) does seems brok=
en
> without checking the 'option' argument to see which arg we can va_arg.
>
> The problem is adding this logic on libc will add some forward-compatibil=
ity
> that we try to avoid (newer kernel prctl additions might now work correct=
ly).
>
> I am not sure why we haven't switch x32 back to the assembly wrappers
> with 6a04404521ac4119ae36827eeb288ea84eee7cf6 fix (BZ#29770).  H.J, can
> use remove the x32 C version (and also or1k as well)?

Since the variadic prctl function takes at most 5 integer arguments which
are passed in the same integer registers on x32 as the function with 5
integer arguments, we can safely use assembly syscall wrapper for prctl
for x32.

Tested on x32.  I leave or1k alone since I don't know if it is safe to
do the same.

--=20
H.J.

--0000000000007b8c210645549c2e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x32-Switch-back-to-assembly-syscall-wrapper-for-prct.patch"
Content-Disposition: attachment; 
	filename="0001-x32-Switch-back-to-assembly-syscall-wrapper-for-prct.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_miv6pcbm0>
X-Attachment-Id: f_miv6pcbm0

RnJvbSBlNmExNDE1NGU5MGUxZTZiYTIzNzIzNDBiNjJkYWUxMzY2N2JjOGJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFN1biwgNyBEZWMgMjAyNSAxMTozMzozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHgzMjogU3dp
dGNoIGJhY2sgdG8gYXNzZW1ibHkgc3lzY2FsbCB3cmFwcGVyIGZvciBwcmN0bAoKU2luY2UgdGhl
IHZhcmlhZGljIHByY3RsIGZ1bmN0aW9uIHRha2VzIGF0IG1vc3QgNSBpbnRlZ2VyIGFyZ3VtZW50
cyB3aGljaAphcmUgcGFzc2VkIGluIHRoZSBzYW1lIGludGVnZXIgcmVnaXN0ZXJzIG9uIHgzMiBh
cyB0aGUgZnVuY3Rpb24gd2l0aCA1CmludGVnZXIgYXJndW1lbnRzLCB3ZSBjYW4gc2FmZWx5IHVz
ZSBhc3NlbWJseSBzeXNjYWxsIHdyYXBwZXIgZm9yIHByY3RsCmZvciB4MzIuCgpTaWduZWQtb2Zm
LWJ5OiBILkouIEx1IDxoamwudG9vbHNAZ21haWwuY29tPgotLS0KIHN5c2RlcHMvdW5peC9zeXN2
L2xpbnV4L3g4Nl82NC94MzIvcHJjdGwuYyB8IDQyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA0MiBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBzeXNkZXBz
L3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMyL3ByY3RsLmMKCmRpZmYgLS1naXQgYS9zeXNkZXBz
L3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMyL3ByY3RsLmMgYi9zeXNkZXBzL3VuaXgvc3lzdi9s
aW51eC94ODZfNjQveDMyL3ByY3RsLmMKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDcx
NGZkMjg4MzcuLjAwMDAwMDAwMDAKLS0tIGEvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0
L3gzMi9wcmN0bC5jCisrKyAvZGV2L251bGwKQEAgLTEsNDIgKzAsMCBAQAotLyogcHJjdGwgLSBM
aW51eCBzcGVjaWZpYyBzeXNjYWxsLiAgeDg2LTY0IHgzMiB2ZXJzaW9uLgotICAgQ29weXJpZ2h0
IChDKSAyMDIwLTIwMjUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuCi0gICBUaGlzIGZp
bGUgaXMgcGFydCBvZiB0aGUgR05VIEMgTGlicmFyeS4KLQotICAgVGhlIEdOVSBDIExpYnJhcnkg
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCi0gICBtb2Rp
ZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljCi0g
ICBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBl
aXRoZXIKLSAgIHZlcnNpb24gMi4xIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91ciBvcHRpb24p
IGFueSBsYXRlciB2ZXJzaW9uLgotCi0gICBUaGUgR05VIEMgTGlicmFyeSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAotICAgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKLSAgIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUg
R05VCi0gICBMZXNzZXIgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgot
Ci0gICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgTGVzc2VyIEdl
bmVyYWwgUHVibGljCi0gICBMaWNlbnNlIGFsb25nIHdpdGggdGhlIEdOVSBDIExpYnJhcnk7IGlm
IG5vdCwgc2VlCi0gICA8aHR0cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LiAgKi8KLQotI2lu
Y2x1ZGUgPHN5c2RlcC5oPgotI2luY2x1ZGUgPHN0ZGFyZy5oPgotI2luY2x1ZGUgPHN5cy9wcmN0
bC5oPgotCi0vKiBVbmNvbmRpdGlvbmFsbHkgcmVhZCBhbGwgcG90ZW50aWFsIGFyZ3VtZW50cy4g
IFRoaXMgbWF5IHBhc3MKLSAgIGdhcmJhZ2UgdmFsdWVzIHRvIHRoZSBrZXJuZWwsIGJ1dCBhdm9p
ZHMgdGhlIG5lZWQgZm9yIHRlYWNoaW5nCi0gICBnbGliYyB0aGUgYXJndW1lbnQgY291bnRzIG9m
IGluZGl2aWR1YWwgb3B0aW9ucyAoaW5jbHVkaW5nIG9uZXMKLSAgIHRoYXQgYXJlIGFkZGVkIHRv
IHRoZSBrZXJuZWwgaW4gdGhlIGZ1dHVyZSkuICAqLwotCi1pbnQKLV9fcHJjdGwgKGludCBvcHRp
b24sIC4uLikKLXsKLSAgdmFfbGlzdCBhcmc7Ci0gIHZhX3N0YXJ0IChhcmcsIG9wdGlvbik7Ci0g
IHVuc2lnbmVkIGxvbmcgaW50IGFyZzIgPSB2YV9hcmcgKGFyZywgdW5zaWduZWQgbG9uZyBpbnQp
OwotICB1bnNpZ25lZCBsb25nIGludCBhcmczID0gdmFfYXJnIChhcmcsIHVuc2lnbmVkIGxvbmcg
aW50KTsKLSAgdW5zaWduZWQgbG9uZyBpbnQgYXJnNCA9IHZhX2FyZyAoYXJnLCB1bnNpZ25lZCBs
b25nIGludCk7Ci0gIHVuc2lnbmVkIGxvbmcgaW50IGFyZzUgPSB2YV9hcmcgKGFyZywgdW5zaWdu
ZWQgbG9uZyBpbnQpOwotICB2YV9lbmQgKGFyZyk7Ci0gIHJldHVybiBJTkxJTkVfU1lTQ0FMTF9D
QUxMIChwcmN0bCwgb3B0aW9uLCBhcmcyLCBhcmczLCBhcmc0LCBhcmc1KTsKLX0KLQotbGliY19o
aWRkZW5fZGVmIChfX3ByY3RsKQotd2Vha19hbGlhcyAoX19wcmN0bCwgcHJjdGwpCi0tIAoyLjUy
LjAKCg==
--0000000000007b8c210645549c2e--

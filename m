Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82C17BCA
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765158578; cv=none; b=gP+ckrLE1C6deSgO3ZGfENhIjVAfdqZpXAhn+WJeFXIoYm2op05GDCKFPCC2/blE/YXCVGrx0W554SMqdQXOu+dknPuLYoUsyNgF+n+UjeDiWK2gr5DY9kldLfzNC2LwVeFL10kozgxSRDTYs83TVJb61C9HlNmKm5UFFsjcORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765158578; c=relaxed/simple;
	bh=qacrngNi9S5A8HUzj9SMaN0RG1bwsZn1J5xpvtxzb4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B09GUv/+0jZpViEE6JFKD7bKdfvWIHvyXLEnV40Po1SMlPaQkBfuqBhewMcQrddyGs2rpHW4nvnABvXOVYg5PW7eoTAQRJwhBOiHZDct4/nNsgIuo+SWv5fcdy3XhUyvOMcdohY5iEQvsJgHzECMg35uzQ8e1sy2NNBciVCoFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSVVzayy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSVVzayy"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so3147876a91.2
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2025 17:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765158576; x=1765763376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UdewU4yik52z7f1qg0aglNDSu/DY/yNNZM3wiuVx6kw=;
        b=aSVVzayynsPe7dHNFNmUfgpS3hc+iVnUS7o5NPuGViKtGFQtFUPGYCRcd3W1SLoh1M
         Z/BwnWx6/pXAmB2A/pdPKdeOoCMSH4IATYziimTzMTx31RA2iEsejNwwIuMTmu5zQLH1
         yBquNc7h+vuChUyQXM4czvE5EcNgHr7oC7QMAGAWusYSbQet+1m/agU7LKeqCGUpBouB
         ZWmltMb4mxBr3RKpVK5urIFHXxiiBwI+q947U0dN4Sy9uAny5xKdSecq4NCmrnnK/lp6
         qOc9/FQlVlaEm/6uBzBrSYahmyX41h4XH/XRV5tAHSkKfYxilwyyogUj3GrvvdnJz0xq
         LCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765158576; x=1765763376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdewU4yik52z7f1qg0aglNDSu/DY/yNNZM3wiuVx6kw=;
        b=OH4rTVYiWwt2aGzysOBRNywdqSLDvsbxe9yF0x/rS8R0irAF5fW8kna73ds9AZ+Afd
         ectPD6DRvSmGzKPa9fcPJim2owhAJ1AB65QHWs9lXylTbBzF8aIEol3Ka0QE9KnbEIz4
         VVMJxvCzISXVgElZsMmFmmhcJm3QFLG0qdBS6qKQVmoa+FsJJAStLXA6MpvIWhJpy03g
         NmnE4JZUOmnkASapBg+cp3kcBJRKYKvYAQiOwHFlBHi6TcdExCwH95ZRNKqg54+6ejTF
         pyp3NqJq4w9h/KB4dQMUzsORjR12dMOgmSwI6FdbiLD9goGTnSqVLA1a8932otUA9HJD
         I/zA==
X-Forwarded-Encrypted: i=1; AJvYcCX1i08X5YAGc64hfGfu/kbmPLg7OnBmxJmqx0W5XZ6NiaYZyna0KUQLQngk3mMNhWGnmsoJTqEze4ni@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8nVQnPNCk7QcuLNSRtZ1TUURSqejGDaaGd4+nHxRbdfE0+rl
	WSWUVMJ0qMWfaApn8eu2snsXTOYD/kCSSazTxMPq34447XonsGrqE/gG9u+8i2OEk2pNS1BsSsU
	9Nte6pcmoGfVUxtbUEn9wKl3BhtIg3ks=
X-Gm-Gg: ASbGncv0PqEVR/CJa+Ux/ZujwPg+lJOnJEfQ3BGSD3KxQM0PgjmTlL8UI4pbyS1xxmR
	DZcWIQbWZJ8EO09X2kL31iHwRnUu9IRO3SecbEbsBwKNaU8ILDCzUnNH99BWGyaSYJ/hlfm0b5u
	UO+zP/BixAS0GBjqvmGQ1tnM8pmYApdx5lv1VqxfUSeipR6OCMKpXAbcr1M3h4Qclh2peLKE2Vf
	eQHMkpIGmF/zQ0/fMgUtddQgP0GO/AMVb6nJwIbzxO9tjG7QuPVRh29s7QsFef7AhfZR/UgISo1
	wOGq51VLSoSF69RVKLq6N5hnschm
X-Google-Smtp-Source: AGHT+IGMTdgw/LSh71PHyc5X92bpiXfgqfjiLI1Sy3mHIgTpkaCKiEJGoM5Whweqrhi+9EbqNLCZSwkae8UPGngkvYU=
X-Received: by 2002:a17:90b:1a90:b0:340:b501:7b7d with SMTP id
 98e67ed59e1d1-349a2550a03mr4990705a91.14.1765158576393; Sun, 07 Dec 2025
 17:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601093150.16912-1-alx@kernel.org> <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org> <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
 <lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 8 Dec 2025 09:48:55 +0800
X-Gm-Features: AQt7F2pU5DYQIgDg4zvP8udxc81ef8WU4WtxrMYy-pIH-KK0TWyjm6L3bsEKNl0
Message-ID: <CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
Subject: [PATCH v2] x32: Implement prctl in assembly
To: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Content-Type: multipart/mixed; boundary="000000000000eb3e7006456701d7"

--000000000000eb3e7006456701d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 5:41=E2=80=AFPM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * H. J. Lu:
>
> > On Thu, Dec 4, 2025 at 10:06=E2=80=AFPM Adhemerval Zanella Netto
> > <adhemerval.zanella@linaro.org> wrote:
> >>
> >> The x32 and or1k (which also uses similar implementation) does seems b=
roken
> >> without checking the 'option' argument to see which arg we can va_arg.
> >>
> >> The problem is adding this logic on libc will add some forward-compati=
bility
> >> that we try to avoid (newer kernel prctl additions might now work corr=
ectly).
> >>
> >> I am not sure why we haven't switch x32 back to the assembly wrappers
> >> with 6a04404521ac4119ae36827eeb288ea84eee7cf6 fix (BZ#29770).  H.J, ca=
n
> >> use remove the x32 C version (and also or1k as well)?
> >
> > Since the variadic prctl function takes at most 5 integer arguments whi=
ch
> > are passed in the same integer registers on x32 as the function with 5
> > integer arguments, we can safely use assembly syscall wrapper for prctl
> > for x32.
>
> The C implementation clears the upper 32 bits of registers.  Does the
> assembler wrapper do the same?
>

Here is the v2 patch to implement prctl in assembly for x32.

Since the variadic prctl function takes at most 5 integer arguments which
are passed in the same integer registers on x32 as the function with 5
integer arguments, we can use assembly for prctl.  Since upper 32-bits in
the last 4 arguments of prctl must be cleared to match the x32 prctl
syscall interface where the last 4 arguments are unsigned 64 bit longs,
implement prctl in assembly to clear upper 32-bits in the last 4 arguments
and add a test to verify it.


--=20
H.J.

--000000000000eb3e7006456701d7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-x32-Implement-prctl-in-assembly.patch"
Content-Disposition: attachment; 
	filename="v2-0001-x32-Implement-prctl-in-assembly.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_miwhp1b80>
X-Attachment-Id: f_miwhp1b80

RnJvbSAyMGY5MjIxMTNlNjVmNDgwNmRiNzI0OTM1ZjdhNzQ3ZGI2MzlkYjQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFN1biwgNyBEZWMgMjAyNSAxMTozMzozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIHgzMjog
SW1wbGVtZW50IHByY3RsIGluIGFzc2VtYmx5CgpTaW5jZSB0aGUgdmFyaWFkaWMgcHJjdGwgZnVu
Y3Rpb24gdGFrZXMgYXQgbW9zdCA1IGludGVnZXIgYXJndW1lbnRzIHdoaWNoCmFyZSBwYXNzZWQg
aW4gdGhlIHNhbWUgaW50ZWdlciByZWdpc3RlcnMgb24geDMyIGFzIHRoZSBmdW5jdGlvbiB3aXRo
IDUKaW50ZWdlciBhcmd1bWVudHMsIHdlIGNhbiB1c2UgYXNzZW1ibHkgZm9yIHByY3RsLiAgU2lu
Y2UgdXBwZXIgMzItYml0cyBpbgp0aGUgbGFzdCA0IGFyZ3VtZW50cyBvZiBwY3J0bCBtdXN0IGJl
IGNsZWFyZWQgdG8gbWF0Y2ggdGhlIHgzMiBwcmN0bApzeXNjYWxsIGludGVyZmFjZSB3aGVyZSB0
aGUgbGFzdCA0IGFyZ3VtZW50cyBhcmUgdW5zaWduZWQgNjQgYml0IGxvbmdzLAppbXBsZW1lbnQg
cHJjdGwgaW4gYXNzZW1ibHkgdG8gY2xlYXIgdXBwZXIgMzItYml0cyBpbiB0aGUgbGFzdCA0IGFy
Z3VtZW50cwphbmQgYWRkIGEgdGVzdCB0byB2ZXJpZnkgaXQuCgpTaWduZWQtb2ZmLWJ5OiBILkou
IEx1IDxoamwudG9vbHNAZ21haWwuY29tPgotLS0KIHN5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4
Nl82NC94MzIvTWFrZWZpbGUgICB8ICA2ICsrCiAuLi4vbGludXgveDg2XzY0L3gzMi97cHJjdGwu
YyA9PiBwcmN0bC5TfSAgICAgfCAzOCArKysrKystLS0tLQogLi4uL3N5c3YvbGludXgveDg2XzY0
L3gzMi90c3QtcHJjdGwteDMyLmMgICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKwogMyBmaWxl
cyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKIHJlbmFtZSBzeXNk
ZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMyL3twcmN0bC5jID0+IHByY3RsLlN9ICg1MCUp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi90
c3QtcHJjdGwteDMyLmMKCmRpZmYgLS1naXQgYS9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZf
NjQveDMyL01ha2VmaWxlIGIvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi9NYWtl
ZmlsZQppbmRleCAxNmI3NjhkOGJhLi4wMDRmNDQ5ODgzIDEwMDY0NAotLS0gYS9zeXNkZXBzL3Vu
aXgvc3lzdi9saW51eC94ODZfNjQveDMyL01ha2VmaWxlCisrKyBiL3N5c2RlcHMvdW5peC9zeXN2
L2xpbnV4L3g4Nl82NC94MzIvTWFrZWZpbGUKQEAgLTMsNiArMywxMiBAQCBkZWZhdWx0LWFiaSA6
PSB4MzIKIAogaWZlcSAoJChzdWJkaXIpLG1pc2MpCiBzeXNkZXBfcm91dGluZXMgKz0gYXJjaF9w
cmN0bAorCit0ZXN0cyArPSBcCisgIHRzdC1wcmN0bC14MzIgXAorIyB0ZXN0cworCitDRkxBR1Mt
dHN0LXByY3RsLXgzMi5jICs9ICQobm8tc3RhY2stcHJvdGVjdG9yKQogZW5kaWYKIAogaWZlcSAo
JChzdWJkaXIpLGNvbmZvcm0pCmRpZmYgLS1naXQgYS9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC94
ODZfNjQveDMyL3ByY3RsLmMgYi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQveDMyL3By
Y3RsLlMKc2ltaWxhcml0eSBpbmRleCA1MCUKcmVuYW1lIGZyb20gc3lzZGVwcy91bml4L3N5c3Yv
bGludXgveDg2XzY0L3gzMi9wcmN0bC5jCnJlbmFtZSB0byBzeXNkZXBzL3VuaXgvc3lzdi9saW51
eC94ODZfNjQveDMyL3ByY3RsLlMKaW5kZXggNzE0ZmQyODgzNy4uNDFmNjQzZWE4MCAxMDA2NDQK
LS0tIGEvc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L3gzMi9wcmN0bC5jCisrKyBiL3N5
c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC94MzIvcHJjdGwuUwpAQCAtMSw1ICsxLDUgQEAK
LS8qIHByY3RsIC0gTGludXggc3BlY2lmaWMgc3lzY2FsbC4gIHg4Ni02NCB4MzIgdmVyc2lvbi4K
LSAgIENvcHlyaWdodCAoQykgMjAyMC0yMDI1IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5j
LgorLyogVGhlIHByY3RsIHN5c3RlbSBjYWxsLiAgTGludXgveDMyIHZlcnNpb24uCisgICBDb3B5
cmlnaHQgKEMpIDIwMjUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuCiAgICBUaGlzIGZp
bGUgaXMgcGFydCBvZiB0aGUgR05VIEMgTGlicmFyeS4KIAogICAgVGhlIEdOVSBDIExpYnJhcnkg
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCkBAIC0xNywy
NiArMTcsMjQgQEAKICAgIDxodHRwczovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uICAqLwogCiAj
aW5jbHVkZSA8c3lzZGVwLmg+Ci0jaW5jbHVkZSA8c3RkYXJnLmg+Ci0jaW5jbHVkZSA8c3lzL3By
Y3RsLmg+CiAKLS8qIFVuY29uZGl0aW9uYWxseSByZWFkIGFsbCBwb3RlbnRpYWwgYXJndW1lbnRz
LiAgVGhpcyBtYXkgcGFzcwotICAgZ2FyYmFnZSB2YWx1ZXMgdG8gdGhlIGtlcm5lbCwgYnV0IGF2
b2lkcyB0aGUgbmVlZCBmb3IgdGVhY2hpbmcKLSAgIGdsaWJjIHRoZSBhcmd1bWVudCBjb3VudHMg
b2YgaW5kaXZpZHVhbCBvcHRpb25zIChpbmNsdWRpbmcgb25lcwotICAgdGhhdCBhcmUgYWRkZWQg
dG8gdGhlIGtlcm5lbCBpbiB0aGUgZnV0dXJlKS4gICovCisvKiBDbGVhciB1cHBlciAzMi1iaXRz
IGluIHRoZSBsYXN0IDQgYXJndW1lbnRzLiAgU2luY2UgdGhlIGZpcnN0IGFyZ3VtZW50CisgICBv
ZiBwcmN0bCBpcyBpbnQsIGxlYXZlIGl0IGFsb25lLiAgKi8KKyN1bmRlZglET19DQUxMCisjZGVm
aW5lIERPX0NBTEwoc3lzY2FsbF9uYW1lLCBhcmdzLCB1bG9uZ19hcmdfMSwgdWxvbmdfYXJnXzIp
IFwKKyAgbW92bCAlZXNpLCAlZXNpOwkJCVwKKyAgbW92bCAlZWR4LCAlZWR4OwkJCVwKKyAgbW92
bCAlZWN4LCAlcjEwZDsJCQlcCisgIG1vdmwgJXI4ZCwgJXI4ZDsJCQlcCisgIG1vdmwgJFNZU19p
ZnkgKHN5c2NhbGxfbmFtZSksICVlYXg7CVwKKyAgc3lzY2FsbDsKIAotaW50Ci1fX3ByY3RsIChp
bnQgb3B0aW9uLCAuLi4pCi17Ci0gIHZhX2xpc3QgYXJnOwotICB2YV9zdGFydCAoYXJnLCBvcHRp
b24pOwotICB1bnNpZ25lZCBsb25nIGludCBhcmcyID0gdmFfYXJnIChhcmcsIHVuc2lnbmVkIGxv
bmcgaW50KTsKLSAgdW5zaWduZWQgbG9uZyBpbnQgYXJnMyA9IHZhX2FyZyAoYXJnLCB1bnNpZ25l
ZCBsb25nIGludCk7Ci0gIHVuc2lnbmVkIGxvbmcgaW50IGFyZzQgPSB2YV9hcmcgKGFyZywgdW5z
aWduZWQgbG9uZyBpbnQpOwotICB1bnNpZ25lZCBsb25nIGludCBhcmc1ID0gdmFfYXJnIChhcmcs
IHVuc2lnbmVkIGxvbmcgaW50KTsKLSAgdmFfZW5kIChhcmcpOwotICByZXR1cm4gSU5MSU5FX1NZ
U0NBTExfQ0FMTCAocHJjdGwsIG9wdGlvbiwgYXJnMiwgYXJnMywgYXJnNCwgYXJnNSk7Ci19CitQ
U0VVRE8gKF9fcHJjdGwsIHByY3RsLCA1KQorCXJldAorUFNFVURPX0VORCAoX19wcmN0bCkKIAog
bGliY19oaWRkZW5fZGVmIChfX3ByY3RsKQogd2Vha19hbGlhcyAoX19wcmN0bCwgcHJjdGwpCito
aWRkZW5fd2VhayAocHJjdGwpCit3ZWFrX2FsaWFzIChfX3ByY3RsLCBfX3ByY3RsX3RpbWU2NCkK
K2hpZGRlbl93ZWFrIChfX3ByY3RsX3RpbWU2NCkKZGlmZiAtLWdpdCBhL3N5c2RlcHMvdW5peC9z
eXN2L2xpbnV4L3g4Nl82NC94MzIvdHN0LXByY3RsLXgzMi5jIGIvc3lzZGVwcy91bml4L3N5c3Yv
bGludXgveDg2XzY0L3gzMi90c3QtcHJjdGwteDMyLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMC4uMjk1YjA5ZTM2NAotLS0gL2Rldi9udWxsCisrKyBiL3N5c2RlcHMvdW5p
eC9zeXN2L2xpbnV4L3g4Nl82NC94MzIvdHN0LXByY3RsLXgzMi5jCkBAIC0wLDAgKzEsNjMgQEAK
Ky8qIFNtb2tlIHRlc3QgZm9yIHByY3RsLgorICAgQ29weXJpZ2h0IChDKSAyMDIxLTIwMjUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuCisgICBUaGlzIGZpbGUgaXMgcGFydCBvZiB0aGUg
R05VIEMgTGlicmFyeS4KKworICAgVGhlIEdOVSBDIExpYnJhcnkgaXMgZnJlZSBzb2Z0d2FyZTsg
eW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisgICBtb2RpZnkgaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljCisgICBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIKKyAgIHZlcnNpb24g
Mi4xIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9u
LgorCisgICBUaGUgR05VIEMgTGlicmFyeSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLAorICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0
IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRO
RVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCisgICBMZXNzZXIgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorCisgICBZb3Ugc2hvdWxkIGhh
dmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljCisgICBM
aWNlbnNlIGFsb25nIHdpdGggdGhlIEdOVSBDIExpYnJhcnk7IGlmIG5vdCwgc2VlCisgICA8aHR0
cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LiAgKi8KKworI2luY2x1ZGUgPHN0ZGludC5oPgor
I2luY2x1ZGUgPHN5cy9wcmN0bC5oPgorI2luY2x1ZGUgPHN1cHBvcnQvY2hlY2suaD4KKworLyog
T24geDMyLCB3aGVuIHBhcmFtZXRlcnMgYXJlIHBhc3NlZCBpbiA2NC1iaXQgcmVnaXN0ZXJzLCBv
bmx5IHRoZSBsb3dlcgorICAgMzIgYml0cyBhcmUgdXNlZCBhbmQgdGhlIHVwcGVyIDMyIGJpdHMg
bXVzdCBiZSBjbGVhcmVkLiAgKi8KK3R5cGVkZWYgdW5pb24KK3sKKyAgc3RydWN0CisgICAgewor
ICAgICAgdW5pb24KKwl7CisJICBjb25zdCBjaGFyICpwdHI7CisJICBpbnQgaTE7CisJfTsKKyAg
ICAgIGludCBpMjsKKyAgICB9IHM7CisgIGxvbmcgbG9uZyBsbDsKK30gcGFyYW1ldGVyX3Q7CisK
K3N0YXRpYyBpbnQKK19fYXR0cmlidXRlX18gKChub2lwYSkpCitkb19wcmN0bCAoaW50IG9wLCBs
b25nIGxvbmcgYXJnMSwgbG9uZyBsb25nIGFyZzIsIGxvbmcgbG9uZyBhcmczLAorCSAgbG9uZyBs
b25nIGFyZzQpCit7CisgIHJldHVybiBwcmN0bCAob3AsIGFyZzEsIGFyZzIsIGFyZzMsIGFyZzQp
OworfQorCitzdGF0aWMgaW50Citkb190ZXN0ICh2b2lkKQoreworICBwYXJhbWV0ZXJfdCBuYW1l
ID0geyB7IHsgInRocmVhZCBuYW1lIiB9LCAtMSB9IH07CisgIHBhcmFtZXRlcl90IHplcm8gPSB7
IHsgeyAwIH0sIC0yIH0gfTsKKyAgVEVTVF9DT01QQVJFIChkb19wcmN0bCAoUFJfU0VUX05BTUUs
IG5hbWUubGwsIHplcm8ubGwsIHplcm8ubGwsCisJCQkgIHplcm8ubGwpLCAwKTsKKyAgY2hhciBi
dWZmZXJbMTZdID0geyAwLCB9OworICBuYW1lLnMucHRyID0gYnVmZmVyOworICBURVNUX0NPTVBB
UkUgKGRvX3ByY3RsIChQUl9HRVRfTkFNRSwgbmFtZS5sbCwgemVyby5sbCwgemVyby5sbCwKKwkJ
CSAgemVyby5sbCksIDApOworICBjaGFyIGV4cGVjdGVkWzE2XSA9ICJ0aHJlYWQgbmFtZSI7Cisg
IFRFU1RfQ09NUEFSRV9CTE9CIChidWZmZXIsIHNpemVvZiAoYnVmZmVyKSwgZXhwZWN0ZWQsIHNp
emVvZiAoZXhwZWN0ZWQpKTsKKyAgcmV0dXJuIDA7Cit9CisKKyNpbmNsdWRlIDxzdXBwb3J0L3Rl
c3QtZHJpdmVyLmM+Ci0tIAoyLjUyLjAKCg==
--000000000000eb3e7006456701d7--

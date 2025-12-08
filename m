Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DD2DC765
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184512; cv=none; b=NhHym+XzMt8F1iJYN1O0PWlZ968rvCB8r4Yh+k4mC+1MQGoZaE0FSMfPiHMIUX4HbQXPxOCmqL3X+SIUP8RfIVVF9t6fNJqVaZs2QbBh9RmMIUVsUn2kEIBvW9JCBgr9APr/D4C4GnF9yPJkWNqTnipl11NGpFQiW+Ys4FhT0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184512; c=relaxed/simple;
	bh=YmtTYy0tXRT+2lc66J2MlROBgLNwfDmHi7M9BvcBOMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyGQ9kGEFZIvS7duQf8XhdJia5KmYJHdi/JqTymhOlkyRWbtFWcRsfNlqrDpQPSCb45KA4kA86ZwpC2FJ4LKwcNffjupQuQfTYGTwqwCCsr16MpP+JrqRtL98oAgUelzSuFAPcryOqfT4BSuY4wjpHV9oT/aaJUjag+CG5YgesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCQAUAwe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQAUAwe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-349ff18445aso545346a91.3
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2025 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765184511; x=1765789311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE+vjVLVBJl+2hLSChaiV2DDqCfAUpBPosZE/0Ex78U=;
        b=LCQAUAwexmSbMo+vGfBTVFam9gw7xasy4g2l8zfow5vkZJsVuhIlNRq7UiCumQ1sWy
         5blNAwNVZDhSfZ2UIplymMCPF4ZcTKa4UjyyHqVHdmVhqPH9jA/ZxOegitruEo1b+Jy1
         eUIqZ/j9aVOiHQE5ClCa+lhJm4oZhQinxv0FtfCwtaocoB+a3lexin8T7/A3k3qI41Sc
         jNiGQpAfhAzYGKMwlEIfd1cY2eS3n7kbHKGqIJ0+QWCeV8wW4JAYrIpJEhbznWaZowTW
         OSFGNF6dPUqbbqwgSxjFu/xJjSJWVo5/HXXvdtqPrauMNTu9zoGfozSSv32lwMClB80g
         cRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184511; x=1765789311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UE+vjVLVBJl+2hLSChaiV2DDqCfAUpBPosZE/0Ex78U=;
        b=whzY1V5V0wtSmkx26QvYVIMJTDB+tyQ8PkYUNXag4TavfkVqVOckgbyoAuO17QZEMu
         CSNQUFpaa+YpJeQnmlrtx0iCCdId0UOJbmxbNIFPbWfQQnsyuJSzPslYlHkhwzAoPrK6
         ZwRQ/tfexu/sMbfKigsIfHjzH0W6nn78tJ7sQ2enCmdJdysHcxrI3iDGgCs2EfmIIH+x
         o3wJta4KEFXMKSfLwSGS/XL02MAPM1ZSApt7jeHxPp7/cEHajBuxqRz7SffB141cEkGr
         J6sUwcZ81hp8PNCe7jh8B/0k8PVjlfTHJ9yLiEbvCGkirlSpliQuS2OzC+IUG3RxVKqO
         nCDw==
X-Forwarded-Encrypted: i=1; AJvYcCWRdLupEpious7d2utv9OXPe4K0YKSTICxa8CTg6E4NzG4kIcQmUtmYmnM+tSYMICGzXy/ik0wtTmh9@vger.kernel.org
X-Gm-Message-State: AOJu0YzNF6V74R2jUYvWOAJkoRh/q3F+91JijHoHX5m9grQsoOdDh9wE
	TB45TdVYYqRDgFUPLI2/5ge27js8OOPG4Qohvc4m3FBgZ5nBhr+0k7xx2XrNhOog99UHJ/hEw4z
	kaOUMLWllmC0ofPehKX/QX8341phuxC8=
X-Gm-Gg: ASbGnctVjvLflxy6atqzryq49xoNkktWSh1NsmYpuNUxGVJup5QDIK6gCaHUo9uhjGU
	EqMot4J6LdnUE+nHNmxyNYPCtX3fRTQmNKS9qtInxOS8r10AUEq8P9F8euHLinCra+n7KmmY/hz
	+OagHssRFYZroxd8PaAcntrCIeYdcT0hOm3dMn/lXTkRaIJML6rVz8zm2rp4zMOT8X9QhePjDkd
	zu2FUeBbo2XAG28GbdglLbonsrRyuwxUJezdNqqqzf5lauhhwHfQaK89h+LldPuhD3ECljk
X-Google-Smtp-Source: AGHT+IEvxieG9OBqmnDowLg8glxG6mrEznvf/IcW5Kv0P6+9uGasIUJBqkUq6pXjVX4uIF2UZ4q1oKLeRGGGMRqzj7E=
X-Received: by 2002:a17:90b:4d07:b0:340:e8e9:cc76 with SMTP id
 98e67ed59e1d1-349a254f664mr5739066a91.11.1765184510610; Mon, 08 Dec 2025
 01:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601093150.16912-1-alx@kernel.org> <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org> <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
 <lhuh5u2aat0.fsf@oldenburg.str.redhat.com> <CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
 <lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 8 Dec 2025 17:01:14 +0800
X-Gm-Features: AQt7F2oLe0QLcjCL7m-UIdiCcxHzmJ-5WDCgnxFp1c-0u_3sSc2CJlD-So57sdY
Message-ID: <CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
Subject: Re: [PATCH v2] x32: Implement prctl in assembly
To: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 4:11=E2=80=AFPM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * H. J. Lu:
> > Here is the v2 patch to implement prctl in assembly for x32.
> >
> > Since the variadic prctl function takes at most 5 integer arguments whi=
ch
> > are passed in the same integer registers on x32 as the function with 5
> > integer arguments, we can use assembly for prctl.  Since upper 32-bits =
in
> > the last 4 arguments of prctl must be cleared to match the x32 prctl
> > syscall interface where the last 4 arguments are unsigned 64 bit longs,
> > implement prctl in assembly to clear upper 32-bits in the last 4 argume=
nts
> > and add a test to verify it.
>
> What's the advantage of the assembler implementation over the C
> implementation?  I'm missing the context for this change.
>

It is inspired by

commit 6a04404521ac4119ae36827eeb288ea84eee7cf6
Author: Florian Weimer <fweimer@redhat.com>
Date:   Sat Feb 17 09:17:04 2024 +0100

    Linux: Switch back to assembly syscall wrapper for prctl (bug 29770)

The difference is

00000000 <__GI___prctl>:
   0: f3 0f 1e fa          endbr64
   4: 8d 44 24 08          lea    0x8(%rsp),%eax
   8: 48 89 74 24 d0        mov    %rsi,-0x30(%rsp)
   d: 48 63 ff              movslq %edi,%rdi
  10: 8b 74 24 d0          mov    -0x30(%rsp),%esi
  14: 89 44 24 c0          mov    %eax,-0x40(%rsp)
  18: 8d 44 24 c8          lea    -0x38(%rsp),%eax
  1c: 48 89 54 24 d8        mov    %rdx,-0x28(%rsp)
  21: 8b 54 24 d8          mov    -0x28(%rsp),%edx
  25: 48 89 4c 24 e0        mov    %rcx,-0x20(%rsp)
  2a: 44 8b 54 24 e0        mov    -0x20(%rsp),%r10d
  2f: 4c 89 44 24 e8        mov    %r8,-0x18(%rsp)
  34: 44 8b 44 24 e8        mov    -0x18(%rsp),%r8d
  39: 89 44 24 c4          mov    %eax,-0x3c(%rsp)
  3d: b8 9d 00 00 40        mov    $0x4000009d,%eax
  42: c7 44 24 b8 08 00 00 00 movl   $0x8,-0x48(%rsp)
  4a: 0f 05                syscall
  4c: 3d 00 f0 ff ff        cmp    $0xfffff000,%eax
  51: 77 05                ja     58 <__GI___prctl+0x58>
  53: c3                    ret
  54: 0f 1f 40 00          nopl   0x0(%rax)
  58: f7 d8                neg    %eax
  5a: 64 8b 14 25 00 00 00 00 mov    %fs:0x0,%edx
  62: 40 03 15 00 00 00 00 rex add 0x0(%rip),%edx        # 69
<__GI___prctl+0x69>
  69: 67 89 02              mov    %eax,(%edx)
  6c: b8 ff ff ff ff        mov    $0xffffffff,%eax
  71: c3                    ret

vs

00000000 <__GI___prctl>:
   0: 89 f6                mov    %esi,%esi
   2: 89 d2                mov    %edx,%edx
   4: 41 89 ca              mov    %ecx,%r10d
   7: 45 89 c0              mov    %r8d,%r8d
   a: b8 9d 00 00 40        mov    $0x4000009d,%eax
   f: 0f 05                syscall
  11: 48 3d 01 f0 ff ff    cmp    $0xfffffffffffff001,%rax
  17: 73 01                jae    1a <__GI___prctl+0x1a>
  19: c3                    ret
  1a: 48 8b 0d 00 00 00 00 mov    0x0(%rip),%rcx        # 21 <__GI___prctl+=
0x21>
  21: f7 d8                neg    %eax
  23: 64 89 01              mov    %eax,%fs:(%rcx)
  26: 83 c8 ff              or     $0xffffffff,%eax
  29: c3                    ret


--=20
H.J.

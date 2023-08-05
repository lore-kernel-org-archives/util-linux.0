Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A270C001DB
	for <util-linux@archiver.kernel.org>; Sat,  5 Aug 2023 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHETsK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 5 Aug 2023 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETsK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 5 Aug 2023 15:48:10 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57CA4
        for <util-linux@vger.kernel.org>; Sat,  5 Aug 2023 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rR9HCldVW64G4XXm7UytmnnAvWnLDMq19KikQ2dQNZM=; b=hDJ25GVO9ELniUQmBfRHaj/PPh
        0oScwoOW2mL4lYTfio7fuArW/dhrOd+gg9sRgq2lywobo0/iVkx0iZ6LWC1nN4H/Kg7GK/887mLY8
        ahjCLO3+XkhJXICP0hVAd/Ybk+IbwYXs29hdICmyrdueRyaiduVFlU7JLJgF5zMNRHfFz2q+Y3Gbg
        no/mRePTboUSyZ1F7nzVxynzfGSYouAKK9m6jrB/r0+RCnwnaXgKjohOrdMQUaqDQbzxJ9D0flVtE
        Ea76YjS0KwPzH38est+nfT+hvMosf/kBMU/2tJLVkljkvHkwxCZRsihsVp7jRFx8y6iRVycebMO3o
        qPJ57NFw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <zeha@debian.org>)
        id 1qSNFr-004Akd-JI; Sat, 05 Aug 2023 19:48:03 +0000
Date:   Sat, 5 Aug 2023 21:47:54 +0200
From:   Chris Hofstaedtler <zeha@debian.org>
To:     John David Anglin <dave@parisc-linux.org>, 1042990@bugs.debian.org
Cc:     util-linux@vger.kernel.org
Subject: Re: Bug#1042990: util-linux: FTBFS on hppa - #error Unknown target
 architecture
Message-ID: <ZM6nalLh925rB6Wm@per>
References: <169109718399.27344.6781194558562181818.reportbug@mx3210>
 <ZMwiib5TVDcXcCR3@mx3210.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMwiib5TVDcXcCR3@mx3210.localdomain>
X-Debian-User: zeha
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Dave,

* John David Anglin <dave@parisc-linux.org> [230803]:
[..]
> The audit architecture defines for hppa are defined in /usr/include/linux/audit.h:
>
> #define AUDIT_ARCH_PARISC       (EM_PARISC)
> #define AUDIT_ARCH_PARISC64     (EM_PARISC|__AUDIT_ARCH_64BIT)
> 
> Please add the architecture defines for hppa to include/audit-arch.h.

could you please forward your patch to util-linux@vger.kernel.org
including a proper Signed-Off-By line? Then upstream can apply it
and downstreams do not need to carry the same patches over and over
again.

* John David Anglin <dave@parisc-linux.org> [230803]:
> Patch.
> 
> Regards,
> Dave Anglin

Thanks,
Chris


> --- ./include/audit-arch.h.save	2023-08-03 20:42:00.937401304 +0000
> +++ ./include/audit-arch.h	2023-08-03 20:53:40.755627981 +0000
> @@ -57,6 +57,12 @@
>  #    else
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH64
>  #    endif
> +#elif __hppa__
> +#    if __SIZEOF_POINTER__ == 4
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PARISC
> +#    else
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PARISC64
> +#    endif
>  #else
>  #    error Unknown target architecture
>  #endif



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A21BD4E5
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234248; cv=none; b=ft4HDAzby1E4ZkgZv3g1v8laDwA8JJEerv08dYWV9GFM+whlWUGpHxBPHMTCI5gdTP4dUy5i+eoZ80tumxWrJSAcol57fx7Vu11NfIpGv8duUF1DWGXA1ZTRf+sh8vPxTKmY8FHzQX3UIlrEi00pKzSicq6g6lJsV/pT6N7oNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234248; c=relaxed/simple;
	bh=92wzOthsFTxiwKf4IgIPs3pzOYpJfmfLGKTNwQtxMwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrwK+4hn/QEt8COGGFRupgYyHQzHodIPc2JkeyxA7QgpI93rBYDJ7IdX/D18M/rP5YbgLC8rABC5ISziYkAElzQOiUWiUVSVcppjAz9G+oZvZ1EwFIhpYa6xXSU/+OV3QJVf6XsmMxvJsYAHCxC/njV9FntZc8nvPiN9NnH21eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ntbaj+yz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntbaj+yz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738234245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDgWw8m/GwYeQj/Gw6lQ8Lkm6qu81zkJI+rejWuMckk=;
	b=Ntbaj+yz4edQzv6N2P5X6BbYaX+fnfw2uZVACj1LUOqSlvN6hSaq+a7MbFmaieYdd3uALl
	OP2GVCw64478zYT04ALtcjEsIQbU8V502rM7c0jOWdAuBPG6SAR7LRaunn8tRC7qJ/GN1p
	1C/K050a2XQWALiHX2nZ6PHx9fw/8S0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-qexT4QuIPrS-3ADkpVKF8g-1; Thu,
 30 Jan 2025 05:50:43 -0500
X-MC-Unique: qexT4QuIPrS-3ADkpVKF8g-1
X-Mimecast-MFC-AGG-ID: qexT4QuIPrS-3ADkpVKF8g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8DF1956083;
	Thu, 30 Jan 2025 10:50:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF8681800358;
	Thu, 30 Jan 2025 10:50:40 +0000 (UTC)
Date: Thu, 30 Jan 2025 11:50:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Mario <marioecht@gmx.de>
Cc: util-linux@vger.kernel.org, dave@gnu.org, kerolasa@iki.fi
Subject: Re: License Combination: LGPL and BSD-4-Clause
Message-ID: <4p7kqcztg6c2qoi5ottk4tfn6zjcm6xppe7fayrdbczrf2xxop@fsmmib2v74cy>
References: <CAFksh4PZbS_+t7QrOQB++xY_1cYc6Fx-4O1f6MPX3VCTf4-ijQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFksh4PZbS_+t7QrOQB++xY_1cYc6Fx-4O1f6MPX3VCTf4-ijQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 22, 2025 at 11:34:50AM GMT, Mario wrote:
 
> The file text-utils/hexdump-parse.c is licensed under the BSD-4-Clause license.
> This file includes the header file include/xalloc.h, which is licensed
> under the LGPL.

I will attempt to change the license of xalloc.{c,h} and colors.{c,h}
to public domain, but this will depend on the other authors. It does
not make sense to use any other license for these commonly used files.

The issue lies with list.h (GPL), which we have already used in old
BSD-based tools such as hexdump, kill, and logger.

> According to the GNU licence compatibility list
> (https://www.gnu.org/licenses/license-list.html.en#OriginalBSD),
> this combination of licenses is not allowed.
> 
> I would like to know:
> 
> How can the resulting binary from this combination be used in a
> license-compliant manner?

Well, ChatGPT has some interesting notes about it:

You're absolutely right—the BSD-4-Clause (with the advertising clause)
is GPL-incompatible, which complicates things when mixing it with LGPL
code. However, since the LGPL header file includes only trivial inline
functions (such as memory allocation and linked list utilities), the
impact on the binary's final license is likely minimal. Here’s why:

    Trivial Inline Functions & LGPL Exception
        The LGPL allows using inline functions and macros in headers
        without imposing LGPL on the entire binary, provided they are
        generic and not substantial parts of the program’s logic.
        Many projects, including the GNU C Library (glibc), use
        LGPL-licensed headers, and applications linking to them are
        not automatically subject to LGPL.

    BSD-4-Clause Licensing Remains for the Main Code
        Since your core program logic remains under BSD-4-Clause and
        the LGPL-covered header only provides minor utilities, your
        program is still primarily BSD-4-Clause.  The advertising
        clause does create GPL/LGPL incompatibility for direct
        combination, but since the inline functions are trivial, it's
        unlikely they trigger a full LGPL conversion.

How to Handle the License Clarification:

    If You Want to Be Safe:
        Replace the LGPL header with a BSD-compatible alternative
        (e.g., a public domain or MIT-licensed equivalent).  If
        possible, move any non-trivial inline functions into a
        separate .c file and dynamically link them under LGPL.

    If Keeping It As-Is:
        Clarify in the documentation that the main program is
        BSD-4-Clause but includes minor LGPL-covered inline functions.
        Users should be informed that these inline functions come from
        LGPL code, but their triviality does not relicense the binary.


> Are there any possible solutions or workarounds to resolve the license
> incompatibility?

I will make an effort to address this issue in the next major release.
We have been gradually resolving the licensing confusion over the past
few years.

For now, from my point of view, hexdump is still BSD-4-Clause licensed
as LGPL is used for trivial wrappers like err-on-malloc, etc.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


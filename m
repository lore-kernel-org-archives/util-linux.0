Received: from mailgate.osadl.org (mailgate.osadl.org [62.245.132.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F01DDC22
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.245.132.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242690; cv=none; b=CcD2z6cLeBvLMlojV9hS2vZpZE8bMGk1SnvSrqzZ9/RJqGEg2J7pVXJeuoHa3wDyBPkfII/5CfaGP8C3tfMvImrG1S7H5JYJzz6qdIExQv2rYH+1rhCzRW5Z3U4ggkySCDs3Sy8jIBqtt0Mks6KbNQArE9FicOOH0uQ6WMUynVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242690; c=relaxed/simple;
	bh=lrhVmYV4naX1LLpMqAkQDRRYTw6cgsAPHSi64lYQ8to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOsFo/cwTlvuSovuO+f+yWZsPHtdQOiqqnn4l7CAY01q3HAVnTi3A9huLxDK0cNILsxnctDzYOpxTViYnAsG26MRAhhd2r3p8gVjsfQYCd/jUyjH8SLO5Rb8+PASrizDCNzfu2FJvyO1e45qerPBPDXU6lzBFCpTjGQdw2oBji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osadl.org; spf=pass smtp.mailfrom=osadl.org; dkim=pass (1024-bit key) header.d=osadl.org header.i=@osadl.org header.b=eci/FEQt; arc=none smtp.client-ip=62.245.132.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osadl.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osadl.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=osadl.org header.i=@osadl.org header.b="eci/FEQt"
Received: from localmail.osadl.org (localmail.osadl.org [192.168.115.248])
	by mailgate.osadl.org (Postfix) with ESMTP id 9AB99300146;
	Thu, 30 Jan 2025 14:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osadl.org; s=default;
	t=1738242299; bh=lrhVmYV4naX1LLpMqAkQDRRYTw6cgsAPHSi64lYQ8to=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eci/FEQt5rDdHNSfq+IvQu0HTHZ4xm8onlLVggQSY5m00MyNj4duKc/6Lyr6hWZjU
	 /5baLbk2vH4wUBWeNuiV6tkJrcU9AzBQXP6y2PApeyACcqWMv/bT+4BE41vrRwoUJc
	 eC57ZydkGOVE5vfEjcDApi0yRqvVP0F/oMMUlNQs=
Received: from localhost (localhost [127.0.0.1])
	by localmail.osadl.org (Postfix) with ESMTP id F1D7C898020;
	Thu, 30 Jan 2025 14:03:24 +0100 (CET)
Received: from localmail.osadl.org ([127.0.0.1])
	by localhost (localmail.osadl.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2d-7bStoCR2Y; Thu, 30 Jan 2025 14:03:20 +0100 (CET)
Received: from [192.168.115.7] (rack0slot7.osadl.org [192.168.115.7])
	by localmail.osadl.org (Postfix) with ESMTP id DA8EC8575AB;
	Thu, 30 Jan 2025 14:03:20 +0100 (CET)
Message-ID: <b6610932-baeb-4407-b959-725e335822b6@osadl.org>
Date: Thu, 30 Jan 2025 14:04:34 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: License Combination: LGPL and BSD-4-Clause
To: Karel Zak <kzak@redhat.com>, Mario <marioecht@gmx.de>
Cc: dave@gnu.org, kerolasa@iki.fi, util-linux@vger.kernel.org
References: <CAFksh4PZbS_+t7QrOQB++xY_1cYc6Fx-4O1f6MPX3VCTf4-ijQ@mail.gmail.com>
 <4p7kqcztg6c2qoi5ottk4tfn6zjcm6xppe7fayrdbczrf2xxop@fsmmib2v74cy>
From: Carsten Emde <C.Emde@osadl.org>
Content-Language: en-US
Organization: Open Source Automation Development Lab (OSADL) eG
In-Reply-To: <4p7kqcztg6c2qoi5ottk4tfn6zjcm6xppe7fayrdbczrf2xxop@fsmmib2v74cy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.9 at mailgate
X-Virus-Status: Clean

Karel,
Mario,

> [..] 
> You're absolutely right—the BSD-4-Clause (with the advertising clause)
> is GPL-incompatible, which complicates things when mixing it with LGPL
> code. However, since the LGPL header file includes only trivial inline
> functions (such as memory allocation and linked list utilities), the
> impact on the binary's final license is likely minimal. Here’s why:
Another opinion:

In 1999, Berkeley University stated:

     July 22, 1999

     To All Licensees, Distributors of Any Version of BSD:

     As you know, certain of the Berkeley Software Distribution ("BSD") 
source code files require that further distributions of products 
containing all or portions of the software, acknowledge within their 
advertising materials that such products contain software developed by 
UC Berkeley and its contributors.

     Specifically, the provision reads:

           * 3. All advertising materials mentioning features or use of 
this software
           *    must display the following acknowledgement:
           *    This product includes software developed by the 
University of
           *    California, Berkeley and its contributors."

     Effective immediately, licensees and distributors are no longer 
required to include the acknowledgement within advertising materials. 
Accordingly, the foregoing paragraph of those BSD Unix files containing 
it is hereby deleted in its entirety.

     William Hoskins
     Director, Office of Technology Licensing
     University of California, Berkeley

The original link 
(ftp://ftp.cs.berkeley.edu/pub/4bsd/README.Impt.License.Change) is no 
longer reachable, but the document is cited at various places on the 
Internet, among other here ->  https://www.freebsd.org/copyright/license/.

We have decided to add the following section to the disclosure material 
we provide along with util-linux:
"The original Berkeley University 4-clause license is now referred to as 
BSD-4-Clause-UC (https://spdx.org/licenses/BSD-4-Clause-UC.html). Since 
this software was continuously maintained after Berkeley University's 
disclaimer of the acknowledgment clause, it is assumed to be licensed 
under BSD-4-clause-UC. Therefore, no acknowledgment is granted and the 
license is considered compatible with GPL/LGPL licenses."

Thanks
	-Carsten

--
Carsten Emde, OSADL
www.osadl.org
C.Emde@osadl.org

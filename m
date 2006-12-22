Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:8347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbWLVRiq (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 12:38:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3035608uga
        for <util-linux-ng@vger.kernel.org>; Fri, 22 Dec 2006 09:38:45 -0800 (PST)
Message-ID: <787b0d920612220938q2011bfdfrf62a693f2f1d4685@mail.gmail.com>
Date: Fri, 22 Dec 2006 12:38:44 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Karel Zak" <kzak@redhat.com>
Subject: Re: splitting util-linux (was: kill)
Cc: "Bryan Henderson" <bryanh@giraffe-data.com>, ethanol@armory.com,
        ams@gnu.org, P@draigbrady.com, util-linux-ng@vger.kernel.org
In-Reply-To: <20061222102404.GU5971@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz>
	 <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
	 <20061221215312.GP5971@petra.dvoda.cz>
	 <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	 <20061222102404.GU5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/22/06, Karel Zak <kzak@redhat.com> wrote:

>  I think we can mark many of these utils as deprecated in 2.13 release
>  and remove it in a future release (2.14). Maybe we can do
>  something like
>
>      ./configure --deprecated="list of wanted deprecated utils"
>
>  it means default installation will be without these tools and
>  nostalgic uses will be compile with the --deprecated option.

Can you get all the obsolete stuff into a separate RPM package?
Somebody might actually want tunelp or fdformat, but the vast
majority of us are totally uninterested.

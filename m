Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85458C433F5
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiAFK4F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:56:05 -0500
Received: from 5.mo575.mail-out.ovh.net ([46.105.62.179]:46103 "EHLO
        5.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFK4E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jan 2022 05:56:04 -0500
Received: from player688.ha.ovh.net (unknown [10.110.208.183])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id CDC0024386
        for <util-linux@vger.kernel.org>; Thu,  6 Jan 2022 10:56:03 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player688.ha.ovh.net (Postfix) with ESMTPSA id 9BA1625EE62AE;
        Thu,  6 Jan 2022 10:56:01 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 06 Jan 2022 11:56:01 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup: restore -f/loopdev alternative
In-Reply-To: <20220106104806.hgqz5hcddmqb5ak4@ws.net.home>
References: <20220106100307.3543758-1-steve@sk2.org>
 <20220106104806.hgqz5hcddmqb5ak4@ws.net.home>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <0970eb98f6c2f7fe5cc2965e1f5c2bf2@sk2.org>
X-Sender: steve@sk2.org
X-Originating-IP: 82.65.25.201
X-Webmail-UserID: steve@sk2.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14610521618667112070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudefledgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeektedvgefghffhleefudeftdejieetgeejgffgvdfgteelvdeuffehkeevtdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehuthhilhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Le 06/01/2022 11:48, Karel Zak a écrit :
> On Thu, Jan 06, 2022 at 11:03:07AM +0100, Stephen Kitt wrote:
>>  sys-utils/losetup.8.adoc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
>> index 2a2577f0d..52df95bd6 100644
>> --- a/sys-utils/losetup.8.adoc
>> +++ b/sys-utils/losetup.8.adoc
>> @@ -30,7 +30,7 @@ Detach all associated loop devices:
>> 
>>  Set up a loop device:
>> 
>> -*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* 
>> _size_] [*-Pr*] [*--show*] *-f* _loopdev file_
>> +*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* 
>> _size_] [*-Pr*] [*--show*] *-f*|_loopdev file_
> 
> Ah, I've just applied 
> https://github.com/util-linux/util-linux/pull/1556
> with the same issue.

Cool, as long as it's fixed :-)

Regards,

Stephen

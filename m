Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90101C3A59F
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 11:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiKWLEM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiKWLDx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 06:03:53 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A412DFA6
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 03:00:13 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 752633200935;
        Wed, 23 Nov 2022 06:00:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Nov 2022 06:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1669201212; x=
        1669287612; bh=6V9MTWClFCpf8VucBqXs0+iXHPLAIMu8NvQEMXnvnpU=; b=O
        QcHTWit3ay7COfo+CoaSCrlOd/sIUiZxjHxOrUwALvdtReaLaCSx5OeHvmfIuhy+
        sX1Jk5FHuk6OdsSTXm69ylr2C4HxZGFmCsyytA0CO0g6GI4LhTMnDNs2xVFyfAGn
        WrhQd2B3ukiJZbPRq5k+TmhekIbmArUUihDuQOBRTsLNu19GayT8MNGHwSIxxPyF
        Q32zY5FuX8mDLVlWsafa882U+mt2rXG33+ELmJJBici7L0dpLnaVkPQThLpIGUFq
        v6SshC/YJsBNNqqLRXr8eCVAad+WxHd6VWo1dCTLTKSftLZItyi1slE9hO5Be4O1
        GvxR3W2/zDw/PXAlHExlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669201212; x=
        1669287612; bh=6V9MTWClFCpf8VucBqXs0+iXHPLAIMu8NvQEMXnvnpU=; b=M
        QLvHW6vcS8c/zu7TGMUYDs/CFIsTFhkt998muDFVRgaCXkM2EhrhPn/7ccgn41q7
        5GQDf2miDZdJ/yhoez/iJIWzmUCydWFEC5LPSKv6KJZNpiHgI47oSdjugl67gVs3
        ItVXUxuE6L0NreRzo+muNEjONLAA+U4rT8h2MLGQK/GjDh8Dnmuo0cX6qV/FNczY
        9knI3C4bX5XdEmxWZg2XKAye6kZBoGl7B1TlPWm9lBZGKsE6vXH2HchRtacGap6M
        kSW1uDWTy1HLSY7t4paCkc9o+wGWLZIq7YKvjdkyj1EVYibFZKQpy5HkHE4x0ytU
        2pYsxkQgqK3NSO9DmNLXA==
X-ME-Sender: <xms:O_19Y0vCHBqFsAtw4zCt6j1-X46s-C6Q6RWT8Dn8cPzDXChOF_-rwA>
    <xme:O_19Yxc46GMsf5__YGr_ymQk4ZP1MQ1_SmvxNw3-SLnR-10YZyruWnuO0VJSdwkHy
    zpB1w0OU0z4>
X-ME-Received: <xmr:O_19Y_zj2MrhRim8xWnF9sIuNccHpV_E3THjSJgcPfHoCFeSZKQfhYuS6ZLTFTutrE4cYOo4rJDe18VYQzEnIPdvWFeMaTjcwmqwPYLYdtBozT8A3IWl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:O_19Y3PmYDRNC7OvnzjuHjFsD3mCV8PTrA560KljEktJr9R7_s-uiw>
    <xmx:O_19Y081lcRQjmgmyuGtta6ds0OPg4Pm_D84rd95S4tPclFS_sNsGw>
    <xmx:O_19Y_VIJ-mW6eysV6BzjiRS5OPh4Pg8xJNjRBAftreyKoKbT6ycOw>
    <xmx:PP19Y9K23O_kNEdVL_RPMOWt76e79glL-RXiHs_SOP5wAg4KzQHBEA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 06:00:10 -0500 (EST)
Message-ID: <0173dc4a-5fc4-bc35-9b08-cc4afcdaffb3@themaw.net>
Date:   Wed, 23 Nov 2022 19:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] libmount: use autofs mount hint to ignore autofs
 mount entries
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
 <166856404555.472741.8761384857533986022.stgit@donald.themaw.net>
 <20221123095636.gmmnayyvssyzgccu@ws.net.home>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20221123095636.gmmnayyvssyzgccu@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


On 23/11/22 17:56, Karel Zak wrote:
> On Wed, Nov 16, 2022 at 10:00:45AM +0800, Ian Kent wrote:
>> diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
>> index 75f8e406b..293f0a8ed 100644
>> --- a/libmount/src/tab_parse.c
>> +++ b/libmount/src/tab_parse.c
>> @@ -762,6 +762,14 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
>>   		if (rc == 0 && tb->fltrcb && tb->fltrcb(fs, tb->fltrcb_data))
>>   			rc = 1;	/* filtered out by callback... */
>>   
>> +		if (mnt_table_ignore_autofs(tb)) {
>   if (rc == 0 && mnt_table_ignore_autofs(tb)) {
>
> Don't waste time if already ignored or in case of error :-)

Will do in v2, thanks.


>
>> +/*
>> + * mnt_table_enable_ignore_autofs:
>> + * @tb: table
>> + *
>> + * Enable ignore autofs mount table entries on reading.
>> + */
>> +int mnt_table_enable_ignore_autofs(struct libmnt_table *tb)
>> +{
>> +	if (!tb)
>> +		return -EINVAL;
>> +	tb->ignore_autofs = 1;
>> +	return 0;
>> +}
>
> The library usually uses the same function to enable as well as disable:
>
> int mnt_table_enable_ignore_autofs(struct libmnt_table *tb, int ignore)
> {
>      if (tb)
>          return -EINVAL;
>      tb->ignore_autofs = ignore ? 1 : 0;
> }
>
> and mnt_context_enable_ignore_autofs() is the same.

Right, I wasn't sure about this.

I had something similar initially.


I'll change it for v2, what about the check-if-enabled function,

any conventions for those?


Ian


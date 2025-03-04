Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A61EC4
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046478; cv=none; b=B+t78qYCPz/PwE41rocelx4v6K0k7Rld0RHDhpz0TdnuWEO/XZ0htndIjVFfe/OvGjvRBbM+gQljNqy32jswF3Ocz5Bcc82UorLIGfPTnKqzMyz/evblxL3MRP7MxEmTeXLt0U6/QGV15EInaQfMEDtE+FNq0iMo3vPpf3C0nDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046478; c=relaxed/simple;
	bh=OdsZakq2ArCBWKepNpcUGfvRCtQKmLWY1N68jCMkTY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3AnCALmHuVcI1D7b7K7PeHvWnYS6rXKtBokQwUodEF3Zyg7tA6MlFroM6g9d2iD85NwIwqVqbGarHHIAM1fWeidmAQqUEzbfI3Pn/BLg9EzfG4Ua7L0sqAEk1/x/V1NnwHKCJMYEjZ+g1N8KRE8rgehGN0RrcAF933IhPi6e98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OxRhe+2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DGcN40E3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OxRhe+2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DGcN40E3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OxRhe+2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGcN40E3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OxRhe+2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGcN40E3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 981CE2117A;
	Tue,  4 Mar 2025 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741046474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5mP2TzSsOb5TlAeHMnyyKvTwwbsRsnZtMVvpo/XYBw=;
	b=OxRhe+2VxoIoTUDvNEArFIqYpN9TaI66A6rXy4l9eQVrlrhJjncAVCErQUQ8cWFnPnHfhO
	KEfp0gcT0upk5MXxYQMpWvAfGkWMiBwVej23H1UIlgVIdXaiB2mIkz2v8RWpj4ioOUnIg5
	7Md+2BEljzcYCi3RW7UuFNhbkYzZNE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741046474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5mP2TzSsOb5TlAeHMnyyKvTwwbsRsnZtMVvpo/XYBw=;
	b=DGcN40E37UB/H3y7UMb68AotUomFgQXSqN//apbWsscr5lyF2jueDoJipuAY+uXzpIbdDl
	qxaM0U6ckB+XDdBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741046474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5mP2TzSsOb5TlAeHMnyyKvTwwbsRsnZtMVvpo/XYBw=;
	b=OxRhe+2VxoIoTUDvNEArFIqYpN9TaI66A6rXy4l9eQVrlrhJjncAVCErQUQ8cWFnPnHfhO
	KEfp0gcT0upk5MXxYQMpWvAfGkWMiBwVej23H1UIlgVIdXaiB2mIkz2v8RWpj4ioOUnIg5
	7Md+2BEljzcYCi3RW7UuFNhbkYzZNE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741046474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5mP2TzSsOb5TlAeHMnyyKvTwwbsRsnZtMVvpo/XYBw=;
	b=DGcN40E37UB/H3y7UMb68AotUomFgQXSqN//apbWsscr5lyF2jueDoJipuAY+uXzpIbdDl
	qxaM0U6ckB+XDdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74AD113A53;
	Tue,  4 Mar 2025 00:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rd7dG8pCxmemKQAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Tue, 04 Mar 2025 00:01:14 +0000
Message-ID: <3e7c81e9-098f-4dd6-bd1a-62731e7a3f5d@suse.cz>
Date: Tue, 4 Mar 2025 01:01:14 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agetty: Implement netlink based IP address lookup
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250216212450.61706-1-sbrabec@suse.cz>
 <tnzflf25amkje3xdgf7avon5smn3xlbng44xxegwpsjjqp4tvy@4vfjbliaoiq3>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <tnzflf25amkje3xdgf7avon5smn3xlbng44xxegwpsjjqp4tvy@4vfjbliaoiq3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Karel Zak wrote:
> On Sun, Feb 16, 2025 at 10:24:50PM GMT, Stanislav Brabec wrote:
>
> My suggestion:
>
> - Move the code to lib/netlink-ifaces.c.
>
> - Add #ifdef TEST_PROGRAM with test main() and test_netlink to
>    lib/Makemodule.am (see for example lib/linux_version.c).
>
> - Use include/debug.h and UL_NETLINK_DEBUG= environment variable (see
>    lib/loopdev.c, LOOPDEV_DEBUG_* and loopdev_init_debug()).
>
> - Use a prefix for public functions (e.g., ul_iface_*).
Makes sense.
> - Create a set of small functions for basic operations:
>    - Add and remove interface (e.g., add_interface()).
>    - Add and remove address.
>    - Get the best address.
It could be done. Just add and delete interface shares lot of code, so 
it could be one function.
> I also suggest using include/list.h for the lists, but you might find
> it challenging at first. Ideally, define next() functions for while()
> loops (e.g., ul_iface_next_interface() and ul_iface_next_addr()). See
> for example libfdisk/src/table.c:fdisk_table_next_partition().
> However, I'll understand if you think it's overkill.
>
> The include/list.h provides a sort function, so it would be possible
> to sort the lists by "quality", making the first address in the list
> the best.
Sounds good. I'll look at it.
>> It could be useful to implement:
>> - configurable limit for the maximum number of interfaces that could be
>>    reported.
> I believe the limit could be quite large by default (512?) since it's
> just one malloc() for each address.
Not for agetty. 512 interfaces surely ovefloods all terminals screen and 
maybe even scrollback memory.
And if you have 512 network interfaces (e. g. modem servers at DSL 
providers), then you probably will not want to report all those 
interfaces IP addresses. But yes, the code could simply support it.

>> - the interface regexp match
> Yes, just another small function ul_iface_match_interface(), and if it
> will be sorted than you get the best one :-)
>
> \4{~eth[0-9]} or \4{match="~eth[0-9]"} if you want to support more
> options in the { }.
Sounds like a good syntax.
>   - agetty already supports \foo{ } arguments, see get_escape_argument()
>   - lib/strutils.c:ul_optstr_next() can parse options list  {a="aaa",b="bbb"}
I see.
>> - an interface template for fine tuning of the output
> You can introduce printf()-like \4{format="%iface:%addr} (like git-log)
>
>> - better control over the output: e. g. disable printing of IPv4 or IPv6
>>    addresses, disable printing of temporary addresses or link-local addresses
>> - cross-protocol checks: e. g. disable reporting of link-local IPv6 address for
>>    an IPv4-only interface
> :-)
>
>> The new network comparison code could potentially render obsolete string based
>> issue comparison (implemented in 6522d88). There are ifaces_list_change_4 and
>> ifaces_list_change_6 variables ready for this purpose.
> Hmm... the global variables used deeply within the netlink message
> parser do not look very elegant. Maybe introduce a separate struct,
> ul_ifaces_status, and use it as a global variable in agetty.c,
> then call process_netlink_msg() with this struct as an argument.
>
>> +struct ip_quality_item {
>> +	enum ip_quality_item_value quality;
>> +	int len;
>> +	__u32 ifa_valid; /* IP addres lifetime */
> uint32_t if possible ;-)
The kernel ifa_valid is declared as __u32. If uint32_t is always equal, 
I'll use it.
> Do we need the _quality_ in the sctruct names? What about ul_iface and
> ul_iface_addr ?
> process_netlink_msg_part() will be simpler and more readable if you
> move the basic tasks to small functions like add_interface() :-)
Actually, if we introduce generic library functions, then other 
consumers may want to do something else than quality evaluation.
I can imagine a generic structure with pointer to custom data. And the 
function will have a callback that will perform the needed operation.

>> +		} else {
>> +			/* Should never happen */
>> +			debug_net("- interface not found\n");
>> +			return;
>> +		}
>> +	}
>> +	if (family == AF_INET) {
>> +		ipq_prev_next = &(ifaceq->ip_quality_list_4);
>> +		ifaces_list_change = &ifaces_list_change_4;
>> +	}
>> +	if (family == AF_INET6) {
>> +		ipq_prev_next = &(ifaceq->ip_quality_list_6);
>> +		ifaces_list_change = &ifaces_list_change_6;
>> +	}
> I guess static analyzers won't like this part; ipq_prev_next is
> uninitialized if the family is something else.
Should never happen, as we use RTMGRP_IPV4_IFADDR or RTMGRP_IPV6_IFADDR 
for netlink_groups. But yes, better safe than sorry.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76


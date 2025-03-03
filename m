Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8730212FA7
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013400; cv=none; b=OS9+JTmbBwBpuEU131MaTT/ftyAiYxHyitXnB1J6+tM6twLwr/5K4uEIQv4P68D+dwPA12mRnVP2Ldbd4Ze8VTdKBTbEqRbx08yKbQIWfx7OggBUFnVezLNdwxHdDB0fcrk/+8onTFoFrKKj1L8vf7ZhymWwcXZdwWMxibRJPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013400; c=relaxed/simple;
	bh=BtQB6syug8iQN+M4iLOdGY4Kw6+VlMUnR8SuhUUGZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvJYLbB+dCZ6jRRkqzLWSM1o4stEasGl126Xy8SrTA3hf7yMNxvEwKmDMCFnuC6sXt21uluTHvF19pYZo5D3O5clMjGIkWgD6vmw6v76xbThlzR/8UraS/gBiKvJ3KFFkUh3DbDAjzLRNhDeP7mvHNfhi3o77q/dltJ/pe04jq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdqNKe4C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdqNKe4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741013397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Kw1DL8MWvGWHyjQ/gfTnywXrqDPnUnII5CBCleynRQ=;
	b=BdqNKe4COVfm+7GwjwMxOkeqVqCur7uGBsV8F6BTaf6cnSn2BXRxunSmrgUVrk+ww5YA/w
	srNMAHBNtHevIfGcKvYGU/w7GE30G/71aQPGko9KUClq3YPU5FNPtToDUpu9PG6I7IQDtE
	4AvE3ssMzfuw+jK5hhKAuiQhfctTfz0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-VqHw6tAVOXOUSjoRmG2QWg-1; Mon,
 03 Mar 2025 09:49:41 -0500
X-MC-Unique: VqHw6tAVOXOUSjoRmG2QWg-1
X-Mimecast-MFC-AGG-ID: VqHw6tAVOXOUSjoRmG2QWg_1741013380
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8651800876;
	Mon,  3 Mar 2025 14:49:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56B48180035F;
	Mon,  3 Mar 2025 14:49:39 +0000 (UTC)
Date: Mon, 3 Mar 2025 15:49:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Implement netlink based IP address lookup
Message-ID: <tnzflf25amkje3xdgf7avon5smn3xlbng44xxegwpsjjqp4tvy@4vfjbliaoiq3>
References: <20250216212450.61706-1-sbrabec@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216212450.61706-1-sbrabec@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Feb 16, 2025 at 10:24:50PM GMT, Stanislav Brabec wrote:
> The new netlink based IP address lokup implements a new issue file escape \i.
> This lookup is based on netlink messages only. It evaluates all addresses
> reported in the netlink messages and it attempts to print only the best of them.
> As it is not possible to discriminate the "best" IP address, it reports all
> reasonably usable addresses.

I believe your code is a good start.

> Migrate \4 and \6 from getifaddrs() to netlink as well, and then completely drop
> getifaddrs() based code.

Yes, but it would be nice to make the code more readable and extendable :-)

My suggestion:

- Move the code to lib/netlink-ifaces.c.

- Add #ifdef TEST_PROGRAM with test main() and test_netlink to
  lib/Makemodule.am (see for example lib/linux_version.c).

- Use include/debug.h and UL_NETLINK_DEBUG= environment variable (see
  lib/loopdev.c, LOOPDEV_DEBUG_* and loopdev_init_debug()).

- Use a prefix for public functions (e.g., ul_iface_*).

- Create a set of small functions for basic operations:
  - Add and remove interface (e.g., add_interface()).
  - Add and remove address.
  - Get the best address.

I also suggest using include/list.h for the lists, but you might find
it challenging at first. Ideally, define next() functions for while()
loops (e.g., ul_iface_next_interface() and ul_iface_next_addr()). See
for example libfdisk/src/table.c:fdisk_table_next_partition().
However, I'll understand if you think it's overkill.

The include/list.h provides a sort function, so it would be possible
to sort the lists by "quality", making the first address in the list
the best.

> It could be useful to implement:
> - configurable limit for the maximum number of interfaces that could be
>   reported.

I believe the limit could be quite large by default (512?) since it's
just one malloc() for each address.

> - the interface regexp match

Yes, just another small function ul_iface_match_interface(), and if it
will be sorted than you get the best one :-)

\4{~eth[0-9]} or \4{match="~eth[0-9]"} if you want to support more
options in the { }.

 - agetty already supports \foo{ } arguments, see get_escape_argument()
 - lib/strutils.c:ul_optstr_next() can parse options list  {a="aaa",b="bbb"}

> - an interface template for fine tuning of the output

You can introduce printf()-like \4{format="%iface:%addr} (like git-log)

> - better control over the output: e. g. disable printing of IPv4 or IPv6
>   addresses, disable printing of temporary addresses or link-local addresses
> - cross-protocol checks: e. g. disable reporting of link-local IPv6 address for
>   an IPv4-only interface

:-)

> The new network comparison code could potentially render obsolete string based
> issue comparison (implemented in 6522d88). There are ifaces_list_change_4 and
> ifaces_list_change_6 variables ready for this purpose.

Hmm... the global variables used deeply within the netlink message
parser do not look very elegant. Maybe introduce a separate struct,
ul_ifaces_status, and use it as a global variable in agetty.c,
then call process_netlink_msg() with this struct as an argument.

> +struct ip_quality_item {
> +	enum ip_quality_item_value quality;
> +	int len;
> +	__u32 ifa_valid; /* IP addres lifetime */

uint32_t if possible ;-)

> +	struct ip_quality_item *next;
> +	char addr[];
> +};
> +struct iface_quality_item {
> +	__u32 ifa_index;
> +	struct ip_quality_item *ip_quality_list_4;
> +	struct ip_quality_item *ip_quality_list_6;
> +	struct iface_quality_item *next;
> +};
> +static struct iface_quality_item *ifaces_list = NULL;
> +bool ifaces_list_change_4;
> +bool ifaces_list_change_6;
> +bool ifaces_skip_dump = false;

Do we need the _quality_ in the sctruct names? What about ul_iface and
ul_iface_addr ?

 ...

> +			debug_net("+ allocating new interface\n");
> +			ifaceq = malloc(sizeof(struct iface_quality_item));

 if (!ifaceq)
    return;

> +			ifaceq->ifa_index = ifaddr->ifa_index;
> +			ifaceq->ip_quality_list_4 = NULL;
> +			ifaceq->ip_quality_list_6 = NULL;
> +			ifaceq->next = NULL;
> +			*ifaceq_prev_next = ifaceq;


process_netlink_msg_part() will be simpler and more readable if you
move the basic tasks to small functions like add_interface() :-)

> +		} else {
> +			/* Should never happen */
> +			debug_net("- interface not found\n");
> +			return;
> +		}
> +	}
> +	if (family == AF_INET) {
> +		ipq_prev_next = &(ifaceq->ip_quality_list_4);
> +		ifaces_list_change = &ifaces_list_change_4;
> +	}
> +	if (family == AF_INET6) {
> +		ipq_prev_next = &(ifaceq->ip_quality_list_6);
> +		ifaces_list_change = &ifaces_list_change_6;
> +	}

I guess static analyzers won't like this part; ipq_prev_next is
uninitialized if the family is something else.

 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


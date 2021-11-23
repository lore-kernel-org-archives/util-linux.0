Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883AC433EF
	for <util-linux@archiver.kernel.org>; Tue, 23 Nov 2021 14:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhKWOgf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234867AbhKWOgd (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Nov 2021 09:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637678005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgkZv6ph3ow2pKJvCM2wQl3bjfFNrcTqMpSndE3onr4=;
        b=GrSiWngWdwE+5hl8vDPNuZcC+Qw7B9qI2akrkLA+kpHEUOw0jUsSM+zc+Z2GjpadNDQO2f
        tR9gW88xcNQQ+wLToHfc/BNCtbYbAQkYCQcabZ//Hro+l3tfCzVGf7MDBanaXmaiFFQuF8
        EtFmOPTJYnPcjZ9rQ3K8ugfpahKWzxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-HzqhDhzyPliSYw4QJ80Bug-1; Tue, 23 Nov 2021 09:33:21 -0500
X-MC-Unique: HzqhDhzyPliSYw4QJ80Bug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C9187950F;
        Tue, 23 Nov 2021 14:33:20 +0000 (UTC)
Received: from ws.net.home (ovpn-112-5.ams2.redhat.com [10.36.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADD7B56A8B;
        Tue, 23 Nov 2021 14:33:18 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:33:15 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>
Subject: Re: [PATCH 3/5] unshare: Add options to map blocks of user/group IDs
Message-ID: <20211123143315.24wzvurbtgnuklnu@ws.net.home>
References: <20211117021038.823851-1-seanga2@gmail.com>
 <20211117021038.823851-4-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117021038.823851-4-seanga2@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi Sean,

the patches looks pretty good, some notes:


On Tue, Nov 16, 2021 at 09:10:36PM -0500, Sean Anderson wrote:
> +static int uint_to_id(const char *cname, size_t sz)
> +{
> +	char old, *name = (char *)cname;

I'm not sure with this, it uses "const char" for good reason. It's
usually better to not touch process argv[].

> +	unsigned long ret;
> +
> +	/* Add a NUL-terminator */
> +	old = name[sz];
> +	name[sz] = '\0';
> +	ret = strtoul_or_err(name, _("could not parse ID"));
> +	if (ret > UINT_MAX)
> +		errx(EXIT_FAILURE, "id %lu is too big", ret);
> +	/* And put back the old value to preserve const-ness */
> +	name[sz] = old;
> +	return ret;
> +}

I think we can keep it simple and robust:

#define UID_BUFSIZ  sizeof(stringify_value(ULONG_MAX))

static int uint_to_id(const char *cname, size_t sz)
{
    char buf[UID_BUFSIZ];
    unsigned long id;

    mem2strcpy(buf, cname, sz, sizeof(buf));
    id = strtoul_or_err(buf, _("could not parse ID"));
    return id;
}

> +/**
> + * map_ids() - Create a new uid/gid map
> + * @idmapper: Either newuidmap or newgidmap
> + * @ppid: Pid to set the map for
> + * @outer: ID outside the namespace for a single map.
> + * @inner: ID inside the namespace for a single map. May be -1 to only use @map.
> + * @map: A range of IDs to map
> + *
> + * This creates a new uid/gid map for @ppid using @idmapper. The ID @outer in
> + * the parent (our) namespace is mapped to the ID @inner in the child (@ppid's)
> + * namespace. In addition, the range of IDs beginning at @map->outer is mapped
> + * to the range of IDs beginning at @map->inner. The tricky bit is that we
> + * cannot let these mappings overlap. We accomplish this by removing a "hole"
> + * from @map, if @outer or @inner overlap it. This may result in one less than
> + * @map->count IDs being mapped from @map. The unmapped IDs are always the
> + * topmost IDs of the mapping (either in the parent or the child namespace).
> + *
> + * Most of the time, this function will be called with @map->outer as some
> + * large ID, @map->inner as 0, and @map->count as a large number (at least
> + * 1000, but less than @map->outer). Typically, there will be no conflict with
> + * @outer. However, @inner may split the mapping for e.g. --map-current-user.
> + *
> + * This function always exec()s or errors out and does not return.
> + */
> +static void __attribute__((__noreturn__))
> +map_ids(const char *idmapper, int ppid, unsigned int outer, unsigned int inner,
> +	struct map_range *map)
> +{
> +	/* idmapper + pid + 4 * map + NULL */
> +	char *argv[15];
> +	/* argv - idmapper - "1" - NULL */
> +	char args[12][16];

May be we can minimize magic constants and use some readable macro here, what about:

args[12][UID_BUFSIZ]

> +	int i = 0, j = 0;
> +	struct map_range lo, mid, hi;
> +	unsigned int inner_offset, outer_offset;
> +
> +	/* Some helper macros to reduce bookkeeping */
> +#define push_str(s) do { \
> +	argv[i++] = s; \
> +} while (0)
> +#define push_ul(x) do { \
> +	snprintf(args[j], 16, "%u", x); \

snprintf(args[j], UID_BUFSIZ, "%u", x);

> +	push_str(args[j++]); \
> +} while (0)

...

> +/**
> + * map_ids_from_child() - Set up a new uid/gid map
> + * @child: The PID of the child process
> + * @fd: The eventfd to send our PID over
> + * @mapuser: The user to map the current user to (or -1)
> + * @usermap: The range of UIDs to map (or %NULL)
> + * @mapgroup: The group to map the current group to (or -1)
> + * @groupmap: The range of GIDs to map (or %NULL)
> + *
> + * Fork (to pid @child) and wait for a message on @fd. Upon recieving this
> + * message, use newuidmap and newgidmap to set the uid/gid map for our parent's
> + * PID.
> + */
> +static void map_ids_from_child(pid_t *child, int *fd, uid_t mapuser,
> +			       struct map_range *usermap, gid_t mapgroup,
> +			       struct map_range *groupmap)
> +{
> +	pid_t pid = 0;
> +	pid_t ppid = getpid();
> +	uint64_t ch;
> +
> +	*fd = eventfd(0, 0);
> +	if (*fd < 0)
> +		err(EXIT_FAILURE, _("eventfd failed"));
> +
> +	*child = fork();
> +	if (*child < 0)
> +		err(EXIT_FAILURE, _("fork failed"));
> +	if (*child)
> +		return;
> +
> +	/* wait for the our parent to call unshare() */
> +	if (read_all(*fd, (char *)&ch, sizeof(ch)) != sizeof(ch) ||
> +	    ch != PIPE_SYNC_BYTE)
> +		err(EXIT_FAILURE, _("failed to read eventfd"));
> +	close(*fd);
> +
> +	/* Avoid forking more than we need to */
> +	if (usermap && groupmap) {
> +		pid = fork();
> +		if (pid < 0)
> +			err(EXIT_FAILURE, _("fork failed"));
> +		if (pid)
> +			waitchild(pid);
> +	}

I like the idea with eventfd(). What about to use it also in
bind_ns_files_from_child()? Now we use pipe() here.

It seems we can consolidate the code and add small functions
like

 sync_with_parent()
 sync_with_child()

to hide SYNC_BYTE read(), write() and waitchild().

 ...

> @@ -413,13 +652,16 @@ int main(int argc, char *argv[])
>  	int c, forkit = 0;
>  	uid_t mapuser = -1;
>  	gid_t mapgroup = -1;
> +	struct map_range *usermap = NULL;
> +	struct map_range *groupmap = NULL;
>  	int kill_child_signo = 0; /* 0 means --kill-child was not used */
>  	const char *procmnt = NULL;
>  	const char *newroot = NULL;
>  	const char *newdir = NULL;
> -	pid_t pid_bind = 0;
> +	pid_t pid_bind = 0, pid_idmap = 0;
>  	pid_t pid = 0;
>  	int fds[2];
> +	int efd;

int fd_idmap, fd_bind;


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


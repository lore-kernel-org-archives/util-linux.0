Return-Path: linux-fsdevel-owner@vger.kernel.org
Date: Fri, 22 Jun 2018 16:43:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Alban Crequy <alban.crequy@gmail.com>
Cc: util-linux@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        linux-fsdevel@vger.kernel.org, dongsu@kinvolk.io,
        Yecheng Fu <cofyc.jackson@gmail.com>
Subject: Re: [PATCH] mountinfo: parse empty strings in source
Message-ID: <20180622144312.rjyfxgvy3krlqx6i@ws.net.home>
References: <20180622115425.26183-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622115425.26183-1-alban@kinvolk.io>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 22, 2018 at 01:54:25PM +0200, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> The source of a mount in /proc/self/mountinfo can unfortunately be an
> empty string. Before this patch, 'mount' and 'mountpoint' fail as
> following:
> 
>   $ sudo mount -t tmpfs "" /tmp/bb
>   $ mount
>   mount: /proc/self/mountinfo: parse error at line 64 -- ignored
>   $ mountpoint /tmp/bb
>   /tmp/bb is not a mountpoint
> 
> This patch fixes the parsing. It is unfortunately more complex because
> sscanf() does not handle fields with empty strings easily.
> 
> Other projects have their own parser for mountinfo and have similar
> issues. I know of runc and runtime-tools (I'll send a patch for those
> two) but there are probably others.

The right place is to fix kernel rather than all places where we parse
the file in userspace. 

There is already a pending trivial kernel patch:
https://patchwork.kernel.org/patch/10349095/ ... but not sure about
the current status of the patch :-(

    Karel

> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  libmount/src/tab_parse.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
> index 3ed84ebc2..4944d5f8c 100644
> --- a/libmount/src/tab_parse.c
> +++ b/libmount/src/tab_parse.c
> @@ -173,13 +173,36 @@ static int mnt_parse_mountinfo_line(struct libmnt_fs *fs, char *s)
>  		fs->opt_fields = strndup(s + 1, p - s - 1);
>  	s = p + 3;
>  
> -	rc += sscanf(s,	UL_SCNsA" "	/* (8) FS type */
> -			UL_SCNsA" "	/* (9) source */
> -			UL_SCNsA,	/* (10) fs options (fs specific) */
> +	end = 0;
> +	rc += sscanf(s,	UL_SCNsA"%n",	/* (8) FS type */
>  
>  			&fstype,
> -			&src,
> -			&fs->fs_optstr);
> +			&end);
> +
> +	if (rc >= 8 && end > 0)
> +		s += end;
> +	if (s[0] == ' ')
> +		s++;
> +
> +	/* (9) source can unfortunately be an empty string "" and scanf does
> +	 * not work well with empty string. Test with:
> +	 *     $ sudo mount -t tmpfs "" /tmp/bb
> +	 *     $ mountpoint /tmp/bb
> +	 * */
> +	if (s[0] == ' ') {
> +		src = strdup("");
> +		s++;
> +		rc++;
> +		rc += sscanf(s,	UL_SCNsA,	/* (10) fs options (fs specific) */
> +
> +				&fs->fs_optstr);
> +	} else {
> +		rc += sscanf(s,	UL_SCNsA" "	/* (9) source */
> +				UL_SCNsA,	/* (10) fs options (fs specific) */
> +
> +				&src,
> +				&fs->fs_optstr);
> +	}
>  
>  	if (rc >= 10) {
>  		size_t sz;
> -- 
> 2.14.3
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

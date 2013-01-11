Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:50303 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255Ab3AKXm2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Jan 2013 18:42:28 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] nsenter: new command (light wrapper around setns)
Date: Fri, 11 Jan 2013 18:45:14 -0500
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home> <87fw27jq29.fsf_-_@xmission.com>
In-Reply-To: <87fw27jq29.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2711447.8jzKOe893v";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301111845.16591.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2711447.8jzKOe893v
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Friday 11 January 2013 17:46:38 Eric W. Biederman wrote:
> --- /dev/null
> +++ b/sys-utils/nsenter.c
>
> +#ifndef CLONE_NEWSNS
> +# define CLONE_NEWNS 0x00020000
> +#endif
> +#ifndef CLONE_NEWUTS
> +# define CLONE_NEWUTS 0x04000000
> +#endif
> +#ifndef CLONE_NEWIPC
> +# define CLONE_NEWIPC 0x08000000
> +#endif
> +#ifndef CLONE_NEWNET
> +# define CLONE_NEWNET 0x40000000
> +#endif
> +#ifndef CLONE_NEWUSER
> +# define CLONE_NEWUSER 0x10000000
> +#endif
> +#ifndef CLONE_NEWPID
> +# define CLONE_NEWPID 0x20000000
> +#endif

this logic really should be in a common header and shared with unshare.c

> +static struct namespace_file{
> +	int nstype;
> +	char *name;

const

> +	/* Careful the order is signifcant in this array.

significant

> +static void open_target_fd(int *fd, const char *type, char *path)

path should be const

> +			namespace_target_pid = strtoul(optarg, &end, 10);
> +			if (!*optarg || (*optarg && *end) || errno != 0) {
> +				err(EXIT_FAILURE,
> +				    _("Pid '%s' is not a valid number"),
> +				    optarg);
> +			}

we really should introduce an xstroul() helper

> +	if (do_fork) {
> +		pid_t child = fork();
> +		if (child < 0)
> +			err(EXIT_FAILURE, _("fork failed"));
> +		if (child != 0) {
> +			int status;
> +			if ((waitpid(child, &status, 0) == child) &&
> +			     WIFEXITED(status)) {
> +				exit(WEXITSTATUS(status));
> +			}
> +			exit(EXIT_FAILURE);

shouldn't this inform the user if the child was killed by a signal ?  maybe:
	if (WIFSIGNALED(status))
		kill(getpid(), WTERMSIG(status));

normalizing the status into EXIT_FAILURE doesn't seem right ...
-mike

--nextPart2711447.8jzKOe893v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ8KQMAAoJEEFjO5/oN/WBtbEQALQs/uVfIDNy2q8QI7CTE8Lp
8TYx1AKMwXeLsDSA/gVBaNJMr/0u6aiQ/Zk32l3CfixyG1cdRl+emwq9A7fQdu07
j14gswGz1NmOUU2PqxWL1w9h7CC/RvQYeUKK9G+SBhGMMAz/GUTAZ+a/9qk33nkU
pzHTloX0qToMMkAixyVaO4fF3xirLOlO/3vs2MGJ7PAMgVFdqanU2E6KotOCiT2g
RAZZDzqGaBmb33J9Rmiyctfa8aL7OMsoiuCqqaBVdN/xjKztWgTTTPBZNKG3SHRv
gsjj2Hl0de3YnLk4zC0qJwGJpJnYvs+1hrw2j4aMhaLyuMTcHucL/lD/DrTNYIXn
XZ33sTifpQvNA6ffawEe0wghq1cimFV2ORJu51IyJ1CGtZk/4h5CkFdnMU5wTzaE
+CcmrLiuqqk3ttFbvWP0dAstD/Mor/hB42i1h4x8qPzb5FAjuN+1Uydz3mjz/OzF
m1/4eWBrqa/EVJQh+sbCgH9sCyJry9cYwL2ejfinCXGN/sDPYjuUKHgJHnCh2RKd
DAIhVQkYZIAxwZhuZa3N+uOfF3p3UAHS7s/Y90gcPoCV6/j8djPlwCOcEMAEyc1h
M3k/ROPpvNxOQvkmaoyeLz5DkD6ejXs/3H931ngeFy7sTOV8fgiEtXBD7Gw2tkbA
oYtmmXal+2jYTH+krr81
=GRNv
-----END PGP SIGNATURE-----

--nextPart2711447.8jzKOe893v--

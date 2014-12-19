Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:48816 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaLSJlS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 04:41:18 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so1119357wiw.10
        for <util-linux@vger.kernel.org>; Fri, 19 Dec 2014 01:41:17 -0800 (PST)
Date: Fri, 19 Dec 2014 09:41:15 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/16] chfn: move new and old finger structs to chfn
 control struct
In-Reply-To: <20141215100735.GZ19904@x2.net.home>
Message-ID: <alpine.LNX.2.03.1412190931130.8955@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi> <1418579052-29386-16-git-send-email-kerolasa@iki.fi> <20141215100735.GZ19904@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 15 Dec 2014, Karel Zak wrote:

> On Sun, Dec 14, 2014 at 05:44:11PM +0000, Sami Kerola wrote:
>> +	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
>> +	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
>> +	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
>> +	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
>
> it would be better to rename prompt() to ask_new_field() or so.

I always forget changing function names is acceptable, and encouraged when 
cleaning up old code.

>> -static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
>> +static int set_changed_data(struct chfn_control *ctl)
>>  {
>>  	int changed = false;
>>
>> -	if (newfp->full_name) {
>> -		oldfp->full_name = newfp->full_name;
>> +	if (ctl->newf.full_name)
>>  		changed = true;
>> -	}
>> -	if (newfp->office) {
>> -		oldfp->office = newfp->office;
>> +	else
>> +		ctl->newf.full_name = ctl->oldf.full_name;
>> +	if (ctl->newf.office)
>>  		changed = true;
>> -	}
>> -	if (newfp->office_phone) {
>> -		oldfp->office_phone = newfp->office_phone;
>> +	else
>> +		ctl->newf.office = ctl->oldf.office;
>> +	if (ctl->newf.office_phone)
>>  		changed = true;
>> -	}
>> -	if (newfp->home_phone) {
>> -		oldfp->home_phone = newfp->home_phone;
>> +	else
>> +		ctl->newf.office_phone = ctl->oldf.office_phone;
>> +	if (ctl->newf.home_phone)
>>  		changed = true;
>> -	}
>> -
>> +	else
>> +		ctl->newf.home_phone = ctl->oldf.home_phone;
>>  	return changed;
>>  }
>
> this is ugly and unnecessary function, all you need is to return
> usable data from prompt() and maintain ctl->changed with in the
> function. The prompt() knows all the detains.

That is ugly == true.

But there is a case to keep some sort of fill the missing fields around. 
When user supplies change with --office and other options some of the 
fields may not be defined.

Same is true when CHFN_RESTRICT kicks in, and an user might not be able to 
change all fields.

>>  	/* create the new gecos string */
>> -	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
>> -		  pinfo->office_phone, pinfo->home_phone, pinfo->other);
>> +	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", ctl->newf.full_name, ctl->newf.office,
>> +		  ctl->newf.office_phone, ctl->newf.home_phone, ctl->newf.other);
>
> Maybe
>
>  len = xasprintf(&gecos, "%s,%s,%s,%s,%s",
>        ctl->newf.full_name ? ctl->newf.full_name : "",
>        ...
>        );
>
> would be better than set the empty strings to newf (now you mix ""
> and strdup() results in newf).

xasprintf if case needs to: new, or old, or nothing. After trying that the 
code looked even more messy, so I end up writing two changes on top of the 
original change. Basic idea is

1. find old fields
2. get new fields
3. set missing fields to new data from old, or blank
4. write

https://github.com/kerolasa/lelux-utiliteetit/commit/d9e1ac99e420f2521849e336a4e57cce1b875241
https://github.com/kerolasa/lelux-utiliteetit/commit/f723cbf544a7eac2927634f2cb6d802437a2d519

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 14 Dec 2014 17:44:11 +0000
Subject: [PATCH 15/18] chfn: move new and old finger structs to chfn control struct

This change is a little bit messy, and requires a comment the struct
finfo should not have 'struct passwd *pw' as it's member.  The earlier
struct design would have been burden to maintain, and confusing to use.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  login-utils/chfn.c | 165 ++++++++++++++++++++++++-----------------------------
  1 file changed, 76 insertions(+), 89 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 801bdbe..f74ed22 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -55,8 +55,6 @@
  #endif

  struct finfo {
-	struct passwd *pw;
-	char *username;
  	char *full_name;
  	char *office;
  	char *office_phone;
@@ -65,6 +63,13 @@ struct finfo {
  };

  struct chfn_control {
+	struct passwd *pw;
+	char *username;
+	/*  "oldf"  Contains the users original finger information.
+	 *  "newf"  Contains the changed finger information, and contains
+	 *          NULL in fields that haven't been changed.
+	 *  In the end, "newf" is folded into "oldf".  */
+	struct finfo oldf, newf;
  	unsigned int
  		interactive:1;		/* whether to prompt for fields or not */
  };
@@ -121,8 +126,7 @@ static int check_gecos_string(const char *msg, char *gecos)
   *	parse the command line arguments.
   *	returns true if no information beyond the username was given.
   */
-static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
-		       struct finfo *pinfo)
+static void parse_argv(struct chfn_control *ctl, int argc, char **argv)
  {
  	int index, c, status = 0;
  	static const struct option long_options[] = {
@@ -139,19 +143,19 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
  				&index)) != -1) {
  		switch (c) {
  		case 'f':
-			pinfo->full_name = optarg;
+			ctl->newf.full_name = optarg;
  			status += check_gecos_string(_("Name"), optarg);
  			break;
  		case 'o':
-			pinfo->office = optarg;
+			ctl->newf.office = optarg;
  			status += check_gecos_string(_("Office"), optarg);
  			break;
  		case 'p':
-			pinfo->office_phone = optarg;
+			ctl->newf.office_phone = optarg;
  			status += check_gecos_string(_("Office Phone"), optarg);
  			break;
  		case 'h':
-			pinfo->home_phone = optarg;
+			ctl->newf.home_phone = optarg;
  			status += check_gecos_string(_("Home Phone"), optarg);
  			break;
  		case 'v':
@@ -170,7 +174,7 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
  	if (optind < argc) {
  		if (optind + 1 < argc)
  			usage(stderr);
-		pinfo->username = argv[optind];
+		ctl->username = argv[optind];
  	}
  	return;
  }
@@ -179,24 +183,22 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
   *  parse_passwd () --
   *	take a struct password and fill in the fields of the struct finfo.
   */
-static void parse_passwd(struct passwd *pw, struct finfo *pinfo)
+static void parse_passwd(struct chfn_control *ctl)
  {
  	char *gecos;

-	if (!pw)
+	if (!ctl->pw)
  		return;
-	pinfo->pw = pw;
-	pinfo->username = pw->pw_name;
  	/* use pw_gecos - we take a copy since PAM destroys the original */
-	gecos = xstrdup(pw->pw_gecos);
+	gecos = xstrdup(ctl->pw->pw_gecos);
  	/* extract known fields */
-	pinfo->full_name = strsep(&gecos, ",");
-	pinfo->office = strsep(&gecos, ",");
-	pinfo->office_phone = strsep(&gecos, ",");
-	pinfo->home_phone = strsep(&gecos, ",");
+	ctl->oldf.full_name = strsep(&gecos, ",");
+	ctl->oldf.office = strsep(&gecos, ",");
+	ctl->oldf.office_phone = strsep(&gecos, ",");
+	ctl->oldf.home_phone = strsep(&gecos, ",");
  	/*  extra fields contain site-specific information, and can
  	 *  not be changed by this version of chfn.  */
-	pinfo->other = strsep(&gecos, ",");
+	ctl->oldf.other = strsep(&gecos, ",");
  }

  /*
@@ -234,12 +236,12 @@ static char *prompt(const char *question, char *def_val)
   *  ask_info () --
   *	prompt the user for the finger information and store it.
   */
-static void ask_info(struct finfo *oldfp, struct finfo *newfp)
+static void ask_info(struct chfn_control *ctl)
  {
-	newfp->full_name = prompt(_("Name"), oldfp->full_name);
-	newfp->office = prompt(_("Office"), oldfp->office);
-	newfp->office_phone = prompt(_("Office Phone"), oldfp->office_phone);
-	newfp->home_phone = prompt(_("Home Phone"), oldfp->home_phone);
+	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
+	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
+	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
+	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
  	printf("\n");
  }

@@ -247,27 +249,26 @@ static void ask_info(struct finfo *oldfp, struct finfo *newfp)
   *  set_changed_data () --
   *	incorporate the new data into the old finger info.
   */
-static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
+static int set_changed_data(struct chfn_control *ctl)
  {
  	int changed = false;

-	if (newfp->full_name) {
-		oldfp->full_name = newfp->full_name;
+	if (ctl->newf.full_name)
  		changed = true;
-	}
-	if (newfp->office) {
-		oldfp->office = newfp->office;
+	else
+		ctl->newf.full_name = ctl->oldf.full_name;
+	if (ctl->newf.office)
  		changed = true;
-	}
-	if (newfp->office_phone) {
-		oldfp->office_phone = newfp->office_phone;
+	else
+		ctl->newf.office = ctl->oldf.office;
+	if (ctl->newf.office_phone)
  		changed = true;
-	}
-	if (newfp->home_phone) {
-		oldfp->home_phone = newfp->home_phone;
+	else
+		ctl->newf.office_phone = ctl->oldf.office_phone;
+	if (ctl->newf.home_phone)
  		changed = true;
-	}
-
+	else
+		ctl->newf.home_phone = ctl->oldf.home_phone;
  	return changed;
  }

@@ -276,41 +277,41 @@ static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
   *	save the given finger info in /etc/passwd.
   *	return zero on success.
   */
-static int save_new_data(struct finfo *pinfo)
+static int save_new_data(struct chfn_control *ctl)
  {
  	char *gecos;
  	int len;

  	/* null fields will confuse printf(). */
-	if (!pinfo->full_name)
-		pinfo->full_name = "";
-	if (!pinfo->office)
-		pinfo->office = "";
-	if (!pinfo->office_phone)
-		pinfo->office_phone = "";
-	if (!pinfo->home_phone)
-		pinfo->home_phone = "";
-	if (!pinfo->other)
-		pinfo->other = "";
+	if (!ctl->newf.full_name)
+		ctl->newf.full_name = "";
+	if (!ctl->newf.office)
+		ctl->newf.office = "";
+	if (!ctl->newf.office_phone)
+		ctl->newf.office_phone = "";
+	if (!ctl->newf.home_phone)
+		ctl->newf.home_phone = "";
+	if (!ctl->newf.other)
+		ctl->newf.other = "";

  	/* create the new gecos string */
-	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
-		  pinfo->office_phone, pinfo->home_phone, pinfo->other);
+	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", ctl->newf.full_name, ctl->newf.office,
+		  ctl->newf.office_phone, ctl->newf.home_phone, ctl->newf.other);

-	/* remove trailing empty fields (but not subfields of pinfo->other) */
-	if (!pinfo->other[0]) {
+	/* remove trailing empty fields (but not subfields of ctl->newf.other) */
+	if (!ctl->newf.other[0]) {
  		while (len > 0 && gecos[len - 1] == ',')
  			len--;
  		gecos[len] = 0;
  	}

  #ifdef HAVE_LIBUSER
-	if (set_value_libuser("chfn", pinfo->pw->pw_name, pinfo->pw->pw_uid,
+	if (set_value_libuser("chfn", ctl->username, ctl->pw->pw_uid,
  			LU_GECOS, gecos) < 0) {
  #else /* HAVE_LIBUSER */
  	/* write the new struct passwd to the passwd file. */
-	pinfo->pw->pw_gecos = gecos;
-	if (setpwnam(pinfo->pw) < 0) {
+	ctl->pw->pw_gecos = gecos;
+	if (setpwnam(ctl->pw) < 0) {
  		warn("setpwnam failed");
  #endif
  		printf(_
@@ -325,7 +326,6 @@ static int save_new_data(struct finfo *pinfo)
  int main(int argc, char **argv)
  {
  	uid_t uid;
-	struct finfo oldf, newf;
  	struct chfn_control ctl = {
  		.interactive = 1
  	};
@@ -335,44 +335,31 @@ int main(int argc, char **argv)
  	bindtextdomain(PACKAGE, LOCALEDIR);
  	textdomain(PACKAGE);
  	atexit(close_stdout);
-
-	/*
-	 *  "oldf" contains the users original finger information.
-	 *  "newf" contains the changed finger information, and contains NULL
-	 *         in fields that haven't been changed.
-	 *  in the end, "newf" is folded into "oldf".
-	 *
-	 *  the reason the new finger information is not put _immediately_
-	 *  into "oldf" is that on the command line, new finger information
-	 *  can be specified before we know what user the information is
-	 *  being specified for.
-	 */
  	uid = getuid();
-	memset(&oldf, 0, sizeof(oldf));
-	memset(&newf, 0, sizeof(newf));

-	parse_argv(&ctl, argc, argv, &newf);
-	if (!newf.username) {
-		parse_passwd(getpwuid(uid), &oldf);
-		if (!oldf.username)
+	parse_argv(&ctl, argc, argv);
+	if (!ctl.username) {
+		ctl.pw = getpwuid(uid);
+		if (!ctl.pw)
  			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
  			     uid);
+		ctl.username = ctl.pw->pw_name;
  	} else {
-		parse_passwd(getpwnam(newf.username), &oldf);
-		if (!oldf.username)
+		ctl.pw = getpwnam(ctl.username);
+		if (!ctl.pw)
  			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
-			     newf.username);
+			     ctl.username);
  	}
-
+	parse_passwd(&ctl);
  #ifndef HAVE_LIBUSER
-	if (!(is_local(oldf.username)))
+	if (!(is_local(ctl.username)))
  		errx(EXIT_FAILURE, _("can only change local entries"));
  #endif

  #ifdef HAVE_LIBSELINUX
  	if (is_selinux_enabled() > 0) {
  		if (uid == 0) {
-			if (checkAccess(oldf.username, PASSWD__CHFN) != 0) {
+			if (checkAccess(ctl.username, PASSWD__CHFN) != 0) {
  				security_context_t user_context;
  				if (getprevcon(&user_context) < 0)
  					user_context = NULL;
@@ -380,7 +367,7 @@ int main(int argc, char **argv)
  				     _("%s is not authorized to change "
  				       "the finger info of %s"),
  				     user_context ? : _("Unknown user context"),
-				     oldf.username);
+				     ctl.username);
  			}
  		}
  		if (setupDefaultContext(_PATH_PASSWD))
@@ -391,30 +378,30 @@ int main(int argc, char **argv)

  #ifdef HAVE_LIBUSER
  	/* If we're setuid and not really root, disallow the password change. */
-	if (geteuid() != getuid() && uid != oldf.pw->pw_uid) {
+	if (geteuid() != getuid() && uid != ctl.pw->pw_uid) {
  #else
-	if (uid != 0 && uid != oldf.pw->pw_uid) {
+	if (uid != 0 && uid != ctl.oldf.pw->pw_uid) {
  #endif
  		errno = EACCES;
  		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
  		      "altering, change denied"));
  	}

-	printf(_("Changing finger information for %s.\n"), oldf.username);
+	printf(_("Changing finger information for %s.\n"), ctl.username);

  #if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
-	if(!auth_pam("chfn", uid, oldf.username)) {
+	if (!auth_pam("chfn", uid, ctl.username)) {
  		return EXIT_FAILURE;
  	}
  #endif

  	if (ctl.interactive)
-		ask_info(&oldf, &newf);
+		ask_info(&ctl);

-	if (!set_changed_data(&oldf, &newf)) {
+	if (!set_changed_data(&ctl)) {
  		printf(_("Finger information not changed.\n"));
  		return EXIT_SUCCESS;
  	}

-	return save_new_data(&oldf) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+	return save_new_data(&ctl) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
  }
-- 
2.2.0

From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 17 Dec 2014 22:28:03 +0000
Subject: [PATCH 16/18] chfn: rename prompt() to ask_new_field()

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  login-utils/chfn.c | 13 +++++++------
  1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index f74ed22..fabe308 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -202,10 +202,11 @@ static void parse_passwd(struct chfn_control *ctl)
  }

  /*
- *  prompt () --
+ *  ask_new_field () --
   *	ask the user for a given field and check that the string is legal.
   */
-static char *prompt(const char *question, char *def_val)
+static char *ask_new_field(struct chfn_control *ctl, const char *question,
+			   char *def_val)
  {
  	int len;
  	char *ans;
@@ -238,10 +239,10 @@ static char *prompt(const char *question, char *def_val)
   */
  static void ask_info(struct chfn_control *ctl)
  {
-	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
-	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
-	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
-	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
+	ctl->newf.full_name = ask_new_field(ctl, _("Name"), ctl->oldf.full_name);
+	ctl->newf.office = ask_new_field(ctl, _("Office"), ctl->oldf.office);
+	ctl->newf.office_phone = ask_new_field(ctl, _("Office Phone"), ctl->oldf.office_phone);
+	ctl->newf.home_phone = ask_new_field(ctl, _("Home Phone"), ctl->oldf.home_phone);
  	printf("\n");
  }

-- 
2.2.0


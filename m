Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52385 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaI1Rzj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 13:55:39 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so622688wiv.8
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 10:55:38 -0700 (PDT)
Date: Sun, 28 Sep 2014 18:55:24 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: JWP <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
In-Reply-To: <5426D7C0.50108@gmx.com>
Message-ID: <alpine.LNX.2.03.1409281829450.8884@iki.fi>
References: <5426D4C2.4060403@gmx.com> <5426D7C0.50108@gmx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 27 Sep 2014, JWP wrote:

> Allowing hctosys to drift compensate facilitates:
>
> More precise setting of the System Clock early in
> the boot process when --adjust cannot be used
> because the file system is not writeable.
>
> Applies sub second drift corrections immediately,
> where as --adjust cannot.
>
> Reduces boot time by not calling hwclock multiple
> times, e.g., --hctosys early before fsck when the
> file system is read-only, then --adjust later when
> the file system is read-write and --hctosys again
> for drift correction.
>
> Use of --adjust elsewhere may no longer be
> necessary.
>
> Part II
>
> After the original submission of this patch I
> realized that now all operations except --systz
> require drift corrected Hardware Clock time.
> Therefore, it should be done only once early in
> the process. Upon implementation of that premise
> many improvements were facilitated:
>
> * Adds drift correction to --hctosys.
> * Adds setting system time with sub-second precision.
> * Adds --get, a drift corrected 'show' operation.
> * Improves drift factor calculation precision while
>   greatly simplifying its algorithm.
> * Fixes --show bug, printing integer sub-seconds, and
>   now uses a more intuitive positive value.
> * Fixes --predict bug, drift correction must be
>   negated to predict future RTC time.
> * Reduces the number of function arguments and
>   lines of code.
>
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
> sys-utils/hwclock.c | 205 +++++++++++++++++++++++-----------------------------
> 1 file changed, 91 insertions(+), 114 deletions(-)
>
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 474e04f..0dd9ad6 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -181,6 +181,18 @@ static void read_date_from_file(struct tm *tm)
> }
>
> /*
> + * Type time_t to type timeval conversion.
> + */
> +static struct timeval t2tv(time_t timet)

More verbose with function name would be easier to understand.

time_t_to_timeval(time_t timet)

> +{
> +  struct timeval rettimeval;
> +
> +  rettimeval.tv_sec = timet;
> +  rettimeval.tv_usec = 0;
> +  return(rettimeval);
> +}

The util-linux is using linux coding style (at least in most of the 
tools), so:

Tabs are 8 characters, and thus indentations are also 8 characters.

> +/*
>  * The difference in seconds between two times in "timeval" format.
>  */
> double time_diff(struct timeval subtrahend, struct timeval subtractor)
> @@ -678,8 +690,7 @@ set_hardware_clock_exact(const time_t sethwtime,
>  * Include in the output the adjustment "sync_duration".
>  */
> static void
> -display_time(const bool hclock_valid, const time_t systime,
> -	     const double sync_duration)
> +display_time(const bool hclock_valid, struct timeval hwctime)
> {
> 	if (!hclock_valid)
> 		warnx(_
> @@ -691,9 +702,9 @@ display_time(const bool hclock_valid, const time_t systime,
> 		char *format = "%c";
> 		char ctime_now[200];
>
> -		lt = localtime(&systime);
> +		lt = localtime(&hwctime.tv_sec);
> 		strftime(ctime_now, sizeof(ctime_now), format, lt);
> -		printf(_("%s  %.6f seconds\n"), ctime_now, -(sync_duration));
> +		printf(_("%s  .%06d seconds\n"), ctime_now, (int)hwctime.tv_usec);

Why not to avoid cast, and print by using the type the tv_usec is?

printf(_("%s  .%06ld seconds\n"), ctime_now, hwctime.tv_usec);

> 	}
> }
>
> @@ -807,7 +818,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
>  * have.
>  */
> static int
> -set_system_clock(const bool hclock_valid, const time_t newtime,
> +set_system_clock(const bool hclock_valid, const struct timeval newtime,
> 		 const bool testing)
> {
> 	int retcode;
> @@ -818,15 +829,11 @@ set_system_clock(const bool hclock_valid, const time_t newtime,
> 		       "we cannot set the System Time from it."));
> 		retcode = 1;
> 	} else {
> -		struct timeval tv;
> 		struct tm *broken;
> 		int minuteswest;
> 		int rc;
>
> -		tv.tv_sec = newtime;
> -		tv.tv_usec = 0;
> -
> -		broken = localtime(&newtime);
> +		broken = localtime(&newtime.tv_sec);
> #ifdef HAVE_TM_GMTOFF
> 		minuteswest = -broken->tm_gmtoff / 60;	/* GNU extension */
> #else
> @@ -838,7 +845,7 @@ set_system_clock(const bool hclock_valid, const time_t newtime,
> 		if (debug) {
> 			printf(_("Calling settimeofday:\n"));
> 			printf(_("\ttv.tv_sec = %ld, tv.tv_usec = %ld\n"),
> -			       (long)tv.tv_sec, (long)tv.tv_usec);
> +			       (long)newtime.tv_sec, (long)newtime.tv_usec);

casting to long seems unnecessary

> 			printf(_("\ttz.tz_minuteswest = %d\n"), minuteswest);
> 		}
> 		if (testing) {
> @@ -848,7 +855,7 @@ set_system_clock(const bool hclock_valid, const time_t newtime,
> 		} else {
> 			const struct timezone tz = { minuteswest, 0 };
>
> -			rc = settimeofday(&tv, &tz);
> +			rc = settimeofday(&newtime, &tz);
> 			if (rc) {
> 				if (errno == EPERM) {
> 					warnx(_
> @@ -974,9 +981,9 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
>  */
> static void
> adjust_drift_factor(struct adjtime *adjtime_p,
> -		    const time_t nowtime,
> +		    const struct timeval nowtime,
> 		    const bool hclock_valid,
> -		    const time_t hclocktime, const double sync_delay)
> +		    const struct timeval hclocktime)
> {
> 	if (!hclock_valid) {
> 		if (debug)
> @@ -989,7 +996,7 @@ adjust_drift_factor(struct adjtime *adjtime_p,
> 				 "calibration time is zero,\n"
> 				 "so history is bad and calibration startover "
> 				 "is necessary.\n"));
> -	} else if ((hclocktime - adjtime_p->last_calib_time) < 24 * 60 * 60) {
> +	} else if ((hclocktime.tv_sec - adjtime_p->last_calib_time) < 24 * 60 * 60) {
> 		if (debug)
> 			printf(_("Not adjusting drift factor because it has "
> 				 "been less than a day since the last "
> @@ -1009,39 +1016,16 @@ adjust_drift_factor(struct adjtime *adjtime_p,
> 		 * but 195 days + 1 second equals 195 days in floats.)
> 		 */
> 		const double sec_per_day = 24.0 * 60.0 * 60.0;
> -		double atime_per_htime;
> -		double adj_days, cal_days;
> -		double exp_drift, unc_drift;
> 		double factor_adjust;
> 		double drift_factor;
> +	        struct timeval lastCalib;

s/lastCalib/last_calib/

CamelCases are unexpected. When fixing that change also 8 spaces in front 
of the variable to one tab.

>
> -		/* Adjusted time units per hardware time unit */
> -		atime_per_htime = 1.0 + adjtime_p->drift_factor / sec_per_day;
> +		lastCalib = t2tv(adjtime_p->last_calib_time);
>
> -		/* Days since last adjustment (in hardware clock time) */
> -		adj_days = (double)(hclocktime - adjtime_p->last_adj_time)
> -		    / sec_per_day;
> +		factor_adjust = time_diff(nowtime, hclocktime) /
> +				(time_diff(nowtime, lastCalib) / sec_per_day);
>
> -		/* Expected drift (sec) since last adjustment */
> -		exp_drift = adj_days * adjtime_p->drift_factor
> -		    + adjtime_p->not_adjusted;
> -
> -		/* Uncorrected drift (sec) since last calibration */
> -		unc_drift = (double)(nowtime - hclocktime)
> -		    + sync_delay - exp_drift;
> -
> -		/* Days since last calibration (in hardware clock time) */
> -		cal_days = ((double)(adjtime_p->last_adj_time
> -				     - adjtime_p->last_calib_time)
> -			    + adjtime_p->not_adjusted)
> -		    / (sec_per_day * atime_per_htime) + adj_days;
> -
> -		/* Amount to add to previous drift factor */
> -		factor_adjust = unc_drift / cal_days;
> -
> -		/* New drift factor */
> 		drift_factor = adjtime_p->drift_factor + factor_adjust;
> -
> 		if (abs(drift_factor) > MAX_DRIFT) {
> 			if (debug)
> 				printf(_("Clock drift factor was calculated as "
> @@ -1052,19 +1036,19 @@ adjust_drift_factor(struct adjtime *adjtime_p,
> 		} else {
> 			if (debug)
> 				printf(_("Clock drifted %.1f seconds in the past "
> -					 "%d seconds in spite of a drift factor of "
> +					 "%.1f seconds\nin spite of a drift factor of "
> 					 "%f seconds/day.\n"
> 					 "Adjusting drift factor by %f seconds/day\n"),
> -				       unc_drift,
> -				       (int)(nowtime - adjtime_p->last_calib_time),
> +				       time_diff(nowtime, hclocktime),
> +				       time_diff(nowtime, lastCalib),
> 				       adjtime_p->drift_factor, factor_adjust);
> 		}
>
> 		adjtime_p->drift_factor = drift_factor;
> 	}
> -	adjtime_p->last_calib_time = nowtime;
> +	adjtime_p->last_calib_time = nowtime.tv_sec;
>
> -	adjtime_p->last_adj_time = nowtime;
> +	adjtime_p->last_adj_time = nowtime.tv_sec;
>
> 	adjtime_p->not_adjusted = 0;
>
> @@ -1087,26 +1071,23 @@ static void
> calculate_adjustment(const double factor,
> 		     const time_t last_time,
> 		     const double not_adjusted,
> -		     const time_t systime, int *adjustment_p, double *retro_p)
> +		     const time_t systime, struct timeval *tdrift_p)
> {
> 	double exact_adjustment;
>
> 	exact_adjustment =
> 	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
> 	    + not_adjusted;
> -	*adjustment_p = FLOOR(exact_adjustment);
> -
> -	*retro_p = exact_adjustment - (double)*adjustment_p;
> +	tdrift_p->tv_sec = FLOOR(exact_adjustment);
> +	tdrift_p->tv_usec = (exact_adjustment -
> +				 (double)tdrift_p->tv_sec) * 1E6;
> 	if (debug) {
> 		printf(P_("Time since last adjustment is %d second\n",
> 			"Time since last adjustment is %d seconds\n",
> 		       (int)(systime - last_time)),
> 		       (int)(systime - last_time));
> -		printf(P_("Need to insert %d second and refer time back "
> -			 "%.6f seconds ago\n",
> -			 "Need to insert %d seconds and refer time back "
> -			 "%.6f seconds ago\n", *adjustment_p),
> -			 *adjustment_p, *retro_p);
> +		printf(_("Calculated Hardware Clock drift is %ld.%06d seconds\n"),
> +		       (long)tdrift_p->tv_sec, (int)tdrift_p->tv_usec);
> 	}
> }
>
> @@ -1200,7 +1181,7 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)
>  */
> static void
> do_adjustment(struct adjtime *adjtime_p,
> -	      const bool hclock_valid, const time_t hclocktime,
> +	      const bool hclock_valid, const struct timeval hclocktime,
> 	      const struct timeval read_time,
> 	      const bool universal, const bool testing)
> {
> @@ -1220,27 +1201,13 @@ do_adjustment(struct adjtime *adjtime_p,
> 			printf(_("Not setting clock because drift factor %f is far too high.\n"),
> 				adjtime_p->drift_factor);
> 	} else {
> -		int adjustment;
> -		/* Number of seconds we must insert in the Hardware Clock */
> -		double retro;
> -		/*
> -		 * Fraction of second we have to remove from clock after
> -		 * inserting <adjustment> whole seconds.
> -		 */
> -		calculate_adjustment(adjtime_p->drift_factor,
> -				     adjtime_p->last_adj_time,
> -				     adjtime_p->not_adjusted,
> -				     hclocktime, &adjustment, &retro);
> -		if (adjustment > 0 || adjustment < -1) {
> -			set_hardware_clock_exact(hclocktime + adjustment,
> -						 time_inc(read_time, -retro),
> -						 universal, testing);
> -			adjtime_p->last_adj_time = hclocktime + adjustment;
> -			adjtime_p->not_adjusted = 0;
> -			adjtime_p->dirty = TRUE;
> -		} else if (debug)
> -			printf(_("Needed adjustment is less than one second, "
> -				 "so not setting clock.\n"));
> +		set_hardware_clock_exact(hclocktime.tv_sec,
> +					 time_inc(read_time,
> +						  -(hclocktime.tv_usec / 1E6)),
> +					 universal, testing);
> +		adjtime_p->last_adj_time = hclocktime.tv_sec;
> +		adjtime_p->not_adjusted = 0;
> +		adjtime_p->dirty = TRUE;
> 	}
> }
>
> @@ -1283,7 +1250,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 		 const bool hctosys, const bool systohc, const bool systz,
> 		 const struct timeval startup_time,
> 		 const bool utc, const bool local_opt,
> -		 const bool testing, const bool predict)
> +		 const bool testing, const bool predict, const bool get)
> {
> 	/* Contents of the adjtime file, or what they should be. */
> 	struct adjtime adjtime;
> @@ -1302,7 +1269,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 	 * synchronized to its next clock tick when we
> 	 * started up. Defined only if hclock_valid is true.
> 	 */
> -	time_t hclocktime = 0;
> +	struct timeval hclocktime = { 0, 0 };
> +	struct timeval tdrift;
> 	/* local return code */
> 	int rc = 0;
>
> @@ -1312,13 +1280,12 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 			return EX_NOPERM;
> 	}
>
> -	if (!noadjfile
> -	    && (adjust || set || systohc || (!utc && !local_opt) || predict)) {
> +	if (!noadjfile && !(systz && (utc || local_opt))) {
> 		rc = read_adjtime(&adjtime);
> 		if (rc)
> 			return rc;
> 	} else {
> -		/* A little trick to avoid reading the file if we don't have to */
> +		/* A little trick to avoid writing the file if we don't have to */
> 		adjtime.dirty = FALSE;
> 	}
>
> @@ -1330,7 +1297,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 		adjtime.dirty = TRUE;
> 	}
>
> -	if (show || adjust || hctosys || (!noadjfile && !systz && !predict)) {
> +	if (show || get || adjust || hctosys || (!noadjfile && !systz && !predict)) {
> 		/* data from HW-clock are required */
> 		rc = synchronize_to_clock_tick();
>
> @@ -1353,26 +1320,40 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 		 */
> 		if (!rc) {
> 			rc = read_hardware_clock(universal,
> -						 &hclock_valid, &hclocktime);
> +						 &hclock_valid, &hclocktime.tv_sec);
> 			if (rc && !set && !systohc)
> 				return EX_IOERR;
> 		}
> 	}
> -
> -	if (show) {
> -		display_time(hclock_valid, hclocktime,
> -			     time_diff(read_time, startup_time));
> +	hclocktime = predict ? t2tv(set_time) : hclocktime;
> +	calculate_adjustment(adjtime.drift_factor,
> +			     adjtime.last_adj_time,
> +			     adjtime.not_adjusted,
> +			     hclocktime.tv_sec, &tdrift);
> +	if (!show && !predict)
> +		hclocktime = time_inc(tdrift, hclocktime.tv_sec);
> +	if (predict)
> +		hclocktime = time_inc(hclocktime, (double)
> +				      -(tdrift.tv_sec + tdrift.tv_sec / 1E6));
> +	if (show || get) {
> +		display_time(hclock_valid,
> +			     time_inc(hclocktime, -time_diff
> +				      (read_time, startup_time)));
> 	} else if (set) {
> 		set_hardware_clock_exact(set_time, startup_time,
> 					 universal, testing);
> 		if (!noadjfile)
> -			adjust_drift_factor(&adjtime, set_time,
> -					    hclock_valid,
> -					    hclocktime,
> -					    time_diff(read_time, startup_time));
> +			adjust_drift_factor(&adjtime,
> +					    time_inc(t2tv(set_time), time_diff
> +						     (read_time, startup_time)),
> +					    hclock_valid, hclocktime);
> 	} else if (adjust) {
> -		do_adjustment(&adjtime, hclock_valid,
> -			      hclocktime, read_time, universal, testing);
> +		if (tdrift.tv_sec > 0 || tdrift.tv_sec < -1)
> +			do_adjustment(&adjtime, hclock_valid,
> +				      hclocktime, read_time, universal, testing);
> +		else
> +			printf(_("Needed adjustment is less than one second, "
> +				 "so not setting clock.\n"));
> 	} else if (systohc) {
> 		struct timeval nowtime, reftime;
> 		/*
> @@ -1388,10 +1369,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 					 reftime.tv_sec,
> 					 reftime, universal, testing);
> 		if (!noadjfile)
> -			adjust_drift_factor(&adjtime, (time_t)
> -					    reftime.tv_sec,
> -					    hclock_valid, hclocktime, (double)
> -					    read_time.tv_usec / 1E6);
> +			adjust_drift_factor(&adjtime, nowtime,
> +					    hclock_valid, hclocktime);
> 	} else if (hctosys) {
> 		rc = set_system_clock(hclock_valid, hclocktime, testing);
> 		if (rc) {
> @@ -1405,19 +1384,12 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> 			return rc;
> 		}
> 	} else if (predict) {
> -		int adjustment;
> -		double retro;
> -
> -		calculate_adjustment(adjtime.drift_factor,
> -				     adjtime.last_adj_time,
> -				     adjtime.not_adjusted,
> -				     set_time, &adjustment, &retro);
> 		if (debug) {
> 			printf(_
> 			       ("At %ld seconds after 1969, RTC is predicted to read %ld seconds after 1969.\n"),
> -			       set_time, set_time + adjustment);
> +			       set_time, (long)hclocktime.tv_sec);
> 		}
> -		display_time(TRUE, set_time + adjustment, -retro);
> +		display_time(TRUE, hclocktime);
> 	}
> 	if (!noadjfile)
> 		save_adjtime(adjtime, testing);
> @@ -1646,7 +1618,7 @@ int main(int argc, char **argv)
> 	/* Variables set by various options; show may also be set later */
> 	/* The options debug, badyear and epoch_option are global */
> 	bool show, set, systohc, hctosys, systz, adjust, getepoch, setepoch,
> -	    predict, compare;
> +	    predict, compare, get;
> 	bool utc, testing, local_opt, noadjfile, directisa;
> 	char *date_opt;
> #ifdef __alpha__
> @@ -1659,6 +1631,7 @@ int main(int argc, char **argv)
> 		OPT_DATE,
> 		OPT_DIRECTISA,
> 		OPT_EPOCH,
> +		OPT_GET,
> 		OPT_GETEPOCH,
> 		OPT_LOCALTIME,
> 		OPT_NOADJFILE,
> @@ -1706,13 +1679,14 @@ int main(int argc, char **argv)
> 		{"adjfile",	1, 0, OPT_ADJFILE},
> 		{"systz",	0, 0, OPT_SYSTZ},
> 		{"predict-hc",	0, 0, OPT_PREDICT_HC},
> +		{"get",		0, 0, OPT_GET},
> 		{NULL,		0, NULL, 0}
> 	};
>
> 	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
> 		{ 'a','r','s','w',
> -		  OPT_GETEPOCH,	OPT_PREDICT_HC, OPT_SET,
> -		  OPT_SETEPOCH, OPT_SYSTZ },
> +		  OPT_GET, OPT_GETEPOCH, OPT_PREDICT_HC,
> +		  OPT_SET, OPT_SETEPOCH, OPT_SYSTZ },
> 		{ 'u', OPT_LOCALTIME},
> 		{ OPT_ADJFILE, OPT_NOADJFILE },
> 		{ 0 }
> @@ -1749,7 +1723,7 @@ int main(int argc, char **argv)
>
> 	/* Set option defaults */
> 	show = set = systohc = hctosys = systz = adjust = noadjfile = predict =
> -	    compare = FALSE;
> +	    compare = get = FALSE;
> 	getepoch = setepoch = utc = local_opt = directisa = testing = debug = FALSE;
> #ifdef __alpha__
> 	ARCconsole = Jensen = SRM = funky_toy = badyear = FALSE;
> @@ -1839,6 +1813,9 @@ int main(int argc, char **argv)
> 		case OPT_PREDICT_HC:
> 			predict = TRUE;		/* --predict-hc */
> 			break;
> +		case OPT_GET:
> +			get = TRUE;		/* --get */
> +			break;
> #ifdef __linux__
> 		case 'f':
> 			rtc_dev_name = optarg;	/* --rtc */
> @@ -1896,7 +1873,7 @@ int main(int argc, char **argv)
> 	}
>
> 	if (!(show | set | systohc | hctosys | systz | adjust | getepoch
> -	      | setepoch | predict | compare))
> +	      | setepoch | predict | compare | get))
> 		show = 1;	/* default to show */
>
> 	if (getuid() == 0)
> @@ -1953,7 +1930,7 @@ int main(int argc, char **argv)
> 	} else
> 		rc = manipulate_clock(show, adjust, noadjfile, set, set_time,
> 			      hctosys, systohc, systz, startup_time, utc,
> -			      local_opt, testing, predict);
> +			      local_opt, testing, predict, get);
>
> 	hwclock_exit(rc);
> 	return rc;		/* Not reached */

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

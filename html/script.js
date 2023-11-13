const navbarOptions = {
    // https://forums.gta5-mods.com/topic/3842/tutorial-handling-meta
    power: [
        { id: "fMass", label: "Mass", description: "The weight of the vehicle in kg", min: 0, max: 10000 },
        { id: "fInitialDragCoeff", label: "Initial Drag Coefficient", description: "Increase to simulate aerodynamic drag", min: 0, max: 100 },
        { id: "fDownforceModifier", label: "Downforce Modifier", description: "Amount of downforce applied to the vehicle", min: 0, max: 100 },
        { id: "nInitialDriveGears", label: "Drive Gears", description: "Amount of vehicle gears", min: 1, max: 10 },
        { id: "fInitialDriveForce", label: "Drive Force", description: "Transmission force ouput", min: 0, max: 100 },
        { id: "fDriveInertia", label: "Drive Inertia", description: "How fast vehicle redlines", min: 0, max: 2 },
        { id: "fDriveBiasFront", label: "Drive Bias Front", description: "RWD: 0.0 | AWD: 0.5 | FWD: 1.0", min: 0, max: 1 },
        { id: "fInitialDriveMaxFlatVel", label: "Max Drive Velocity", description: "Speed at redline in top gear", min: 0, max: 1000 },
        { id: "fClutchChangeRateScaleUpShift", label: "Clutch Speed Upshift", description: "Higher value = faster shifts", min: 0, max: 100 },
        { id: "fClutchChangeRateScaleDownShift", label: "Clutch Speed Downshift", description: "Higher value = faster shifts", min: 0, max: 100 },
    ],
    braking: [
        { id: "fSteeringLock", label: "Steering Lock", description: "Maximum steering angle of the wheels", min: 0, max: 1 },
        { id: "fBrakeForce", label: "Brake Force", description: "Overall braking power", min: 0, max: 100 },
        { id: "fBrakeBiasFront", label: "Brake Bias Front", description: "Rear: 0.0 | Equal: 0.5 | Front: 1.0", min: 0, max: 1 },
        { id: "fHandBrakeForce", label: "Hand Brake Force", description: "Sets the strength of the handbrake", min: 0, max: 100 },
    ],
    traction: [
        { id: "fTractionCurveMax", label: "Max Traction Curve", description: "Cornering grip of the vehicle", min: 0, max: 100 },
        { id: "fTractionCurveMin", label: "Min Traction Curve", description: "Accelerating/braking grip of the vehicle", min: 0, max: 100 },
        { id: "fTractionCurveLateral", label: "Lateral Traction Curve", description: "Shape of lateral traction curve", min: 0, max: 100 },
        { id: "fTractionSpringDeltaMax", label: "Max Traction Spring Delta", description: "Distance above the ground the car will lose traction", min: 0, max: 100 },
        { id: "fLowSpeedTractionLossMult", label: "Low Speed Traction Loss Multiplier", description: "Lower: less burnout | Higher: more burnout", min: 0, max: 100 },
        { id: "fTractionBiasFront", label: "Traction Bias Front", description: "Rear: 0.1 | Equal: 0.5 | Front: 0.99", min: 0, max: 1 },
        { id: "fCamberStiffnesss", label: "Camber Stiffness", description: "Drifting grip", min: 0, max: 100 },
        { id: "fTractionLossMult", label: "Traction Loss Multiplier", description: "Grip on asphalt and mud", min: 0, max: 100 },
    ],
    suspension: [
        { id: "vecCentreOfMassOffset", label: "Centre of Mass Offset", description: "Shifts the center of gravity right,forwards,upwards", min: 0, max: 100 },
        { id: "vecInertiaMultiplier", label: "Inertia Multiplier", description: "Rotational inertia", min: 0, max: 100 },
        { id: "fSuspensionForce", label: "Suspension Force", description: "Suspension strength", min: 0, max: 100 },
        { id: "fSuspensionCompDamp", label: "Compression Damping", description: "Bigger values = stiffer", min: 0, max: 100 },
        { id: "fSuspensionReboundDamp", label: "Rebound Damping", description: "Bigger values = stiffer", min: 0, max: 100 },
        { id: "fSuspensionUpperLimit", label: "Suspension Upper Limit", description: "Visual limit of how far can wheels move up", min: 0, max: 100 },
        { id: "fSuspensionLowerLimit", label: "Suspension Lower Limit", description: "Visual limit of how far can wheels move down", min: 0, max: 100 },
        { id: "fSuspensionRaise", label: "Suspension Raise", description: "Body height off the wheels", min: 0, max: 100 },
        { id: "fSuspensionBiasFront", label: "Suspension Bias Front", description: "Front/back suspension strength", min: 0, max: 1 },
        { id: "fAntiRollBarForce", label: "Anti Roll Bar Force", description: "Larger numbers = less body roll", min: 0, max: 100 },
        { id: "fAntiRollBarBiasFront", label: "Anti Roll Bar Bias Front", description: "Front: 0 | Rear: 1", min: 0, max: 1 },
        { id: "fRollCentreHeightFront", label: "Roll Centre Height Front", description: "Larger numbers = less rollovers", min: -0.15, max: 0.15 },
        { id: "fRollCentreHeightRear", label: "Roll Centre Height Rear", description: "Larger numbers = less rollovers", min: -0.15, max: 0.15 },
    ],
    miscellaneous: [
        { id: "fPercentSubmerged", label: "Percent Submerged", description: "Percent submerged before considered drowned", min: 0, max: 100 },
        { id: "fCollisionDamageMult", label: "Collision Damage Multiplier", description: "Multipy collision damage", min: 0, max: 10 },
        { id: "fDeformationDamageMult", label: "Deformation Damage Multiplier", description: "Multipy body damage", min: 0, max: 10 },
        { id: "fWeaponDamageMult", label: "Weapon Damage Multiplier", description: "Multipy weapon damage", min: 0, max: 10 },
        { id: "fEngineDamageMult", label: "Engine Damage Multiplier", description: "Multipy engine damage", min: 0, max: 10 },
        { id: "fPetrolTankVolume", label: "Petrol Tank Volume", description: "Amount of petrol that will leak after damaging a vehicle's tank", min: 0, max: 100 },
        { id: "fOilVolume", label: "Oil Volume", description: "Amount of oil", min: 0, max: 100 },
        { id: "nMonetaryValue", label: "Monetary Value", description: "Determine NPC reaction to vehicle", min: 0, max: 1000000 },
    ],
};

let currentStats = {};

const generateNavbarItems = () => {
    const navbar = document.querySelector(".navbar");
    navbar.innerHTML = "";

    Object.keys(navbarOptions).forEach((option) => {
        const button = document.createElement("button");
        button.classList.add("nav-item");
        button.id = option;
        button.textContent = option.charAt(0).toUpperCase() + option.slice(1);
        navbar.appendChild(button);
    });
};

const displayFieldsForNavbarOption = (option) => {
    const contentArea = document.getElementById("content-area");
    contentArea.innerHTML = "";
    const selectedOptions = navbarOptions[option];

    selectedOptions.forEach((option) => {
        const inputContainer = document.createElement("div");
        inputContainer.classList.add("input-container");

        const inputLabel = document.createElement("label");
        inputLabel.classList.add("input-label");
        inputLabel.htmlFor = option.id;
        inputLabel.textContent = option.label || option.id;

        const numberInput = document.createElement("input");
        numberInput.type = "number";
        numberInput.id = option.id;
        numberInput.classList.add("number-input");
        numberInput.value = currentStats[option.id] !== undefined ? currentStats[option.id] : "";

        if (option.min !== undefined) {
            numberInput.min = option.min;
        }
        if (option.max !== undefined) {
            numberInput.max = option.max;
        }

        if (option.description) {
            inputLabel.addEventListener("mouseover", () => {
                document.getElementById("table-description").textContent = option.description;
            });

            inputLabel.addEventListener("mouseout", () => {
                document.getElementById("table-description").textContent = "";
            });
        }

        inputContainer.appendChild(inputLabel);
        inputContainer.appendChild(numberInput);
        contentArea.appendChild(inputContainer);
    });
};

const openTuner = (stats) => {
    currentStats = stats;
    document.querySelector(".tablet").style.display = "block";
    generateNavbarItems();
    displayFieldsForNavbarOption("power");
};

const saveSettings = () => {
    const contentArea = document.getElementById("content-area");
    let data = {};
    let isInputValid = true;

    const inputContainers = contentArea.querySelectorAll(".input-container");
    inputContainers.forEach((container) => {
        const inputElement = container.querySelector(".number-input");
        if (inputElement) {
            const value = parseFloat(inputElement.value);
            const min = parseFloat(inputElement.min);
            const max = parseFloat(inputElement.max);

            if (value < min || value > max) {
                console.log(inputElement.id + " out of range");
                isInputValid = false;
            } else {
                data[inputElement.id] = value;
            }
        }
    });

    if (isInputValid) {
        fetch("https://qb-mechanicjob/saveTune", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
        });
    }
};

const resetSettings = () => {
    fetch("https://qb-mechanicjob/reset", { method: "POST" });
    closeTuner();
};

const closeTuner = () => {
    document.querySelector(".tablet").style.display = "none";
    fetch("https://qb-mechanicjob/closeTuner", { method: "POST" });
};

document.addEventListener("click", function (event) {
    const targetId = event.target.id;
    const targetClass = event.target.className;

    if (targetClass === "nav-item") {
        displayFieldsForNavbarOption(targetId);
        return;
    }

    switch (targetId) {
        case "save-button":
            saveSettings();
            break;
        case "reset-button":
            resetSettings();
            break;
        case "cancel":
            closeTuner();
            break;
    }
});

document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        closeTuner();
    }
});

window.addEventListener("message", function (event) {
    var eventData = event.data;
    if (eventData.action == "openTuner") {
        openTuner(eventData.stats);
    }
});
